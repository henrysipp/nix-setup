# Helpers for Home Manager Hyprland Lua config (configType = "lua").
{lib, ...}: let
  inherit
    (import ./hyprland-theme.nix {
      colors = {
        withHashtag = {
          base00 = "#1A1B26";
          base03 = "#444B6A";
          base0D = "#2AC3DE";
        };
        base00 = "1a1b26";
        base03 = "444b6a";
        base0D = "2ac3de";
      };
    })
    gapInner
    gapOuter
    rounding
    activeBorderColor
    inactiveBorderColor
    shadowColor
    ;

  lua = lib.generators.mkLuaInline;

  withOpts = args: opts:
    if opts == {}
    then args
    else args ++ [opts];

  bindArgs = key: action: opts: withOpts [key action] opts;

  bind' = {
    key,
    dispatch,
    opts ? {},
  }: {
    _args = bindArgs key (lua dispatch) opts;
  };

  bind = key: dispatch: bind' {inherit key dispatch;};

  bindExec = key: cmd:
    bind' {
      inherit key;
      dispatch = ''hl.dsp.exec_cmd("${cmd}")'';
    };

  bindExec' = key: cmd: opts:
    bind' {
      inherit key opts;
      dispatch = ''hl.dsp.exec_cmd("${cmd}")'';
    };

  bindGlobal = key: target:
    bind' {
      inherit key;
      dispatch = ''hl.dsp.global("${target}")'';
    };

  bindFn = key: body:
    bind' {
      inherit key;
      dispatch = ''
        function()
          ${body}
        end
      '';
    };

  bindFn' = key: body: opts:
    bind' {
      inherit key opts;
      dispatch = ''
        function()
          ${body}
        end
      '';
    };

  onExec = event: cmd: {
    _args = [
      event
      (lua ''
        function()
          hl.exec_cmd("${cmd}")
        end
      '')
    ];
  };

  # Work around Hyprland send_shortcut sometimes leaving synthetic key state stuck/repeating.
  # https://github.com/hyprwm/Hyprland/discussions/14099
  bindShortcutOnce = key: mods: shortcutKey:
    bindFn key ''
      hl.dispatch(hl.dsp.send_key_state({ mods = "${mods}", key = "${shortcutKey}", state = "down", window = "activewindow" }))

      hl.timer(function()
        hl.dispatch(hl.dsp.send_key_state({ mods = "${mods}", key = "${shortcutKey}", state = "up", window = "activewindow" }))
      end, { timeout = 50, type = "oneshot" })
    '';

  locked = {
    locked = true;
  };

  lockedRepeating = {
    locked = true;
    repeating = true;
  };

  vars = lib.mapAttrs (_: v: {_var = v;});

  env = name: value: {
    _args = [
      name
      (toString value)
    ];
  };

  envs = lib.mapAttrsToList env;

  curve = name: points: {
    _args = [
      name
      {
        type = "bezier";
        inherit points;
      }
    ];
  };

  curves = lib.map ({
    name,
    points,
  }:
    curve name points);

  animation = {
    leaf,
    speed,
    bezier ? "default",
    style ? null,
    enabled ? true,
  }:
    lib.optionalAttrs (style != null) {inherit style;}
    // {
      inherit leaf enabled speed bezier;
    };

  animations = lib.map animation;

  gesture = args: {
    _args = [args];
  };

  arrowDirections = [
    {
      key = "LEFT";
      dir = "l";
    }
    {
      key = "RIGHT";
      dir = "r";
    }
    {
      key = "UP";
      dir = "u";
    }
    {
      key = "DOWN";
      dir = "d";
    }
  ];

  arrowBinds = lib.flatten (lib.map ({
      key,
      dir,
    }: [
      (bind "SUPER + ${key}" ''hl.dsp.focus({ direction = "${dir}" })'')
      (bind "SUPER + SHIFT + ${key}" ''hl.dsp.window.swap({ direction = "${dir}" })'')
    ])
    arrowDirections);

  workspaceBinds = count:
    lib.flatten (lib.genList (
        i: let
          ws = toString (i + 1);
        in [
          (bind "SUPER + ${ws}" ''hl.dsp.focus({ workspace = "${ws}" })'')
          (bind "SUPER + SHIFT + ${ws}" ''hl.dsp.window.move({ workspace = "${ws}" })'')
        ]
      )
      count);

  # Omarchy-style window/layer rule helpers for configType = "lua".
  # https://github.com/basecamp/omarchy/blob/dev/default/hypr/helpers.lua
  withMatch = match: rules:
    let
      baseMatch = rules.match or {};
      mergedMatch =
        if builtins.isString match
        then baseMatch // {class = match;}
        else baseMatch // match;
    in
      rules // {match = mergedMatch;};

  window = match: rules: withMatch match rules;

  layer = match: rules: withMatch match rules;

  # Load every *.nix file in a directory, sorted (omarchy require_all.files).
  requireApps = appsDir:
    let
      appFiles =
        lib.sort (a: b: a < b)
        (lib.filter
          (name: lib.hasSuffix ".nix" name)
          (builtins.attrNames (builtins.readDir appsDir)));
      appModules =
        map
        (name:
          import (appsDir + "/${name}") {
            inherit lib;
            h = {
              inherit window layer;
            };
          })
        appFiles;
    in {
      windowRules = lib.flatten (map (m: m.windowRules or []) appModules);
      layerRules = lib.flatten (map (m: m.layerRules or []) appModules);
    };
in {
  inherit
    lua
    bind
    bind'
    bindExec
    bindExec'
    bindGlobal
    bindFn
    bindFn'
    bindShortcutOnce
    onExec
    locked
    lockedRepeating
    vars
    env
    envs
    curve
    curves
    animation
    animations
    gesture
    arrowBinds
    workspaceBinds
    window
    layer
    requireApps
    gapInner
    gapOuter
    rounding
    activeBorderColor
    inactiveBorderColor
    shadowColor
    ;
}
