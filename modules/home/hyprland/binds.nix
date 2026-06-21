{lib, ...}: let
  lua = lib.generators.mkLuaInline;

  gapsOn = 8;

  arrowBinds =
    lib.flatten (lib.map (
      {key, dir}:
        [
          {
            _args = [
              "SUPER + ${key}"
              (lua "hl.dsp.focus({ direction = \"${dir}\" })")
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + ${key}"
              (lua "hl.dsp.window.swap({ direction = \"${dir}\" })")
            ];
          }
        ]
    ) [
      {key = "LEFT"; dir = "l";}
      {key = "RIGHT"; dir = "r";}
      {key = "UP"; dir = "u";}
      {key = "DOWN"; dir = "d";}
    ]);

  workspaceBinds = lib.flatten (lib.genList (
    i: let
      ws = toString (i + 1);
    in [
      {
        _args = [
          "SUPER + ${ws}"
          (lua "hl.dsp.focus({ workspace = \"${ws}\" })")
        ];
      }
      {
        _args = [
          "SUPER + SHIFT + ${ws}"
          (lua "hl.dsp.window.move({ workspace = \"${ws}\" })")
        ];
      }
    ]
  ) 5);
in {
  wayland.windowManager.hyprland.settings.bind =
    [
      {
        _args = [
          "SUPER + Space"
          (lua ''hl.dsp.exec_cmd("wofi --show drun")'')
        ];
      }
      {
        _args = [
          "SUPER + CTRL + Space"
          (lua ''hl.dsp.exec_cmd("pkill -SIGUSR2 waybar || waybar")'')
        ];
      }
      {
        _args = [
          "SUPER + W"
          (lua ''hl.dsp.window.close()'')
        ];
      }
      {
        _args = [
          "SUPER + RETURN"
          (lua ''hl.dsp.exec_cmd("ghostty")'')
        ];
      }
      {
        _args = [
          "SUPER + F"
          (lua ''hl.dsp.window.fullscreen({ action = "toggle" })'')
        ];
      }
      {
        _args = [
          "SUPER + SHIFT + BACKSPACE"
          (lua ''
            function()
              local state = rawget(_G, "_hokum_gaps") or { on = true }
              _G._hokum_gaps = state
              if state.on then
                hl.config({ general = { gaps_in = 0, gaps_out = 0 } })
                state.on = false
              else
                hl.config({ general = { gaps_in = ${toString gapsOn}, gaps_out = ${toString gapsOn} } })
                state.on = true
              end
            end
          '')
        ];
      }
      {
        _args = [
          "SUPER + L"
          (lua ''
            function()
              local layout = hl.get_config("general.layout")
              if layout == "scrolling" then
                hl.config({ general = { layout = "dwindle" } })
              else
                hl.config({ general = { layout = "scrolling" } })
              end
            end
          '')
        ];
      }
      {
        _args = [
          "SUPER + SHIFT + B"
          (lua ''hl.dsp.exec_cmd(browser)'')
        ];
      }
      {
        _args = [
          "SUPER + SHIFT + slash"
          (lua ''hl.dsp.exec_cmd(passwordManager)'')
        ];
      }
    ]
    ++ arrowBinds
    ++ workspaceBinds;
}
