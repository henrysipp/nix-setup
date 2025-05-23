{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    hyprpolkitagent
    hyprland-qtutils # needed for banners and ANR messages
  ];
  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = ["--all"];
    };
    xwayland = {
      enable = true;
      hidpi = true;
    };
    nvidiaPatches = true;
    settings = {
      exec-once = [
        "wl-paste --type text --watch cliphist store # Stores only text data"
        "wl-paste --type image --watch cliphist store # Stores only image data"
        "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user start hyprpolkitagent"
        # "killall -q waybar;sleep .5 && waybar"
      ];
      environment = {
        no_donation_nag = true;
        no_update_news = false;
      };

      general = {
        layout = "dwindle";
        gaps_in = 6;
        gaps_out = 8;
        border_size = 2;
        resize_on_border = true;
      };

      "$modifier" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "rofi -show drun";

      cursor = {
        sync_gsettings_theme = true;
        no_hardware_cursors = 2; # change to 1 if want to disable
        enable_hyprcursor = false;
        warp_on_change_workspace = 2;
        no_warps = true;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2;
      };

      env = [
        "NIXOS_OZONE_WL,1"
        "_JAVA_AWT_WM_NONREPARENTING,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORM,wayland"
        "SDL_VIDEODRIVER,wayland"
        "GDK_BACKEND,wayland"
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];
    };

    bind = [
      # General
      "$mod, return, exec, $terminal"
      "$mod SHIFT, q, killactive"
      "$mod SHIFT, e, exit"
      # "$mod SHIFT, l, exec, ${pkgs.hyprlock}/bin/hyprlock"

      # Screen focus
      "$mod, v, togglefloating"
      "$mod, u, focusurgentorlast"
      "$mod, tab, focuscurrentorlast"
      "$mod, f, fullscreen"

      # Screen resize
      "$mod CTRL, h, resizeactive, -20 0"
      "$mod CTRL, l, resizeactive, 20 0"
      "$mod CTRL, k, resizeactive, 0 -20"
      "$mod CTRL, j, resizeactive, 0 20"

      # Workspaces
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"

      # Move to workspaces
      "$mod SHIFT, 1, movetoworkspace,1"
      "$mod SHIFT, 2, movetoworkspace,2"
      "$mod SHIFT, 3, movetoworkspace,3"
      "$mod SHIFT, 4, movetoworkspace,4"
      "$mod SHIFT, 5, movetoworkspace,5"
      "$mod SHIFT, 6, movetoworkspace,6"
      "$mod SHIFT, 7, movetoworkspace,7"
      "$mod SHIFT, 8, movetoworkspace,8"
      "$mod SHIFT, 9, movetoworkspace,9"
      "$mod SHIFT, 0, movetoworkspace,10"

      # Navigation
      "$mod, h, movefocus, l"
      "$mod, l, movefocus, r"
      "$mod, k, movefocus, u"
      "$mod, j, movefocus, d"

      # Applications
      # "$mod ALT, f, exec, ${pkgs.firefox}/bin/firefox"
      # "$mod ALT, e, exec, $terminal --hold -e ${pkgs.yazi}/bin/yazi"
      # "$mod ALT, o, exec, ${pkgs.obsidian}/bin/obsidian"
      # "$mod, r, exec, pkill fuzzel || ${pkgs.fuzzel}/bin/fuzzel"
      # "$mod ALT, r, exec, pkill anyrun || ${pkgs.anyrun}/bin/anyrun"
      "$mod ALT, n, exec, swaync-client -t -sw"

      # Clipboard
      "$mod ALT, v, exec, pkill fuzzel || cliphist list | fuzzel --no-fuzzy --dmenu | cliphist decode | wl-copy"

      # Screencapture
      # "$mod, S, exec, ${pkgs.grim}/bin/grim | wl-copy"
      # "$mod SHIFT+ALT, S, exec, ${pkgs.grim}/bin/grim -g \"$(slurp)\" - | ${pkgs.swappy}/bin/swappy -f -"
    ];

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
}
