{pkgs, ...}: {

    home.packages = [
        pkgs.kitty
        pkgs.wofi
        pkgs.wl-clipboard
    ];

    wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        systemd.enable = true;

        settings = {
            "$terminal" = "alacritty";
            "$mod" = "SUPER";
            "$fileManager" = "dolphin";

            monitor = [
                "DP-1,3840x2160@239.99Hz,0x0,1.25,vrr,2"
            ];

            general = {
                gaps_in = 8;
                gaps_out = 8;
                border_size = 2;
                layout = "dwindle";
            };

            input = {
                kb_layout = "us";
                follow_mouse = true;
                accel_profile = "flat";
            };

            bind = [
                # General
                "$mod, W, killactive"
                "$mod, Return, exec, $terminal"
                "$mod, E, exec, $fileManager"
                "$mod SHIFT, e, exit"
                "$mod SHIFT, L, exec, ${pkgs.hyprlock}/bin/hyprlock"


                # Screen focus
                "$mod, v, togglefloating"
                "$mod, u, focusurgentorlast"
                "$mod, tab, focuscurrentorlast"
                "shift, F11, fullscreen"

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
                "$mod ALT, f, exec, ${pkgs.firefox}/bin/firefox"
                #"$mod ALT, e, exec, $terminal --hold -e ${pkgs.yazi}/bin/yazi"
                #"$mod ALT, o, exec, ${pkgs.obsidian}/bin/obsidian"
                #"$mod, r, exec, pkill fuzzel || ${pkgs.fuzzel}/bin/fuzzel"
                #"$mod ALT, r, exec, pkill anyrun || ${pkgs.anyrun}/bin/anyrun"
                #"$mod ALT, n, exec, swaync-client -t -sw"

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
    };
}