{pkgs, inputs, perSystem, ...}: {

    imports = [
        inputs.ags.homeManagerModules.default
    ];

    home.packages = [
        pkgs.kitty
        pkgs.wofi
        pkgs.wl-clipboard
        pkgs.bibata-cursors
        pkgs.hyprpaper

        pkgs.kdePackages.dolphin
        pkgs.kdePackages.qtsvg
        pkgs.kdePackages.kio-fuse
        pkgs.kdePackages.kio-extras
    ];

    home.file = {
        "Pictures/Wallpapers" = {
            source = ../../config/wallpaper;
            recursive = true;
        };
    };

    services.hyprpaper = {
        enable = true;
        settings = {
            preload = [
                "~/Pictures/Wallpapers/leaf.png"
            ];
            wallpapers = [
                "DP-1,~/Pictures/Wallpapers/leaf.png"
            ];
        };
    };

    programs.ags = {
        enable = true;
        configDir = ../../ags;
        extraPackages = with pkgs; [
            gtksourceview
            webkitgtk
            accountsservice

            perSystem.ags.io
            perSystem.ags.notifd
            perSystem.ags.hyprland
            perSystem.ags.tray
            perSystem.ags.network
            perSystem.ags.wireplumber
        ];
    };

    wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = true;
        # xwayland.enable = true;
        # xwayland.force_zero_scaling = true;
       
        settings = {
	    debug.disable_logs = false;
            "$terminal" = "alacritty";
            "$mod" = "SUPER";
            "$fileManager" = "dolphin";
            "$&" = "override";

            monitor = [
                "DP-1,3840x2160@239.99Hz,0x0,1.5" #,vrr,2"
            ];

            general = {
                gaps_in = 8;
                gaps_out = 16;
                border_size = 2;
                resize_on_border = true;
                allow_tearing = false;
                layout = "dwindle";
            };

            decoration = {
                active_opacity = .85;
                inactive_opacity = 0.65; 
                fullscreen_opacity = 1;
                shadow = {
                    enabled = true;
                    range = 4;
                    render_power = 3;
                    # color = "rgba(1a1a1aee)";
                };

                # blur = {
                #     enabled = true;
                #     special = true;
                #     new_optimizations = true;
                #     size = 8;
                #     passes = 1;
                #     vibrancy = 0.1696;
                # };
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
                # "GBM_BACKEND,nvidia-drm"
                "__GLX_VENDOR_LIBRARY_NAME,nvidia"
                "XCURSOR_THEME,Bibata-Modern-Classic"
                "XCURSOR_SIZE,23"
                "HYPRCURSOR_THEME,Bibata-Modern-Classic"
                "HYPRCURSOR_SIZE,23"
            ];
       
        
            exec-once = [
                "gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Original-Classic'"
                "gsettings set org.gnome.desktop.interface cursor-size 24"
                "hyprctl setcursor Bibata-Modern-Classic 23"
            ];

            input = {
                kb_layout = "us";
                follow_mouse = true;
                accel_profile = "flat";
            };

            animations =  {
                enabled = true;
                # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
                bezier = [
                    "easeOutQuint,0.23,1,0.32,1"
                    "easeInOutCubic,0.65,0.05,0.36,1"
                    "linear,0,0,1,1"
                    "almostLinear,0.5,0.5,0.75,1.0"
                    "quick,0.15,0,0.1,1"
                ];
                animation = [
                    "border, 1, 5.39, easeOutQuint"
                    "windows, 1, 4.79, easeOutQuint"
                    "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
                    "windowsOut, 1, 1.49, linear, popin 87%"
                    "fadeIn, 1, 1.73, almostLinear"
                    "fadeOut, 1, 1.46, almostLinear"
                    "fade, 1, 3.03, quick"
                    "layers, 1, 3.81, easeOutQuint"
                    "layersIn, 1, 4, easeOutQuint, fade"
                    "layersOut, 1, 1.5, linear, fade"
                    "fadeLayersIn, 1, 1.79, almostLinear"
                    "fadeLayersOut, 1, 1.39, almostLinear"
                    "workspaces, 1, 1.94, almostLinear, fade"
                    "workspacesIn, 1, 1.21, almostLinear, fade"
                    "workspacesOut, 1, 1.94, almostLinear, fade"
                ];
            };

            cursor = {
                no_hardware_cursors = false;
                # enable_hyprcursor = true;
                # You can also set size here
                # default_monitor = "DP-2";
            };

            windowrulev2 = [
                # Ignore opacity for windows showing video
                "opacity 1.0 $& 1.0 $& 1,title:^(.*(YouTube|Netflix|Vimeo|Discord).*)$"
                "opacity 1.0 $& 0.90 $& 1,class:^([Cc]ode)$"

                "tag +games, class:^(steam_app_\d+)$"            


                "float, tag:settings*"
                "noblur, tag:games*"
                "fullscreen, tag:games*"
        ];

            bind = [
                # General
                "$mod, W, killactive"
                "$mod, Return, exec, $terminal"
                "$mod, E, exec, $fileManager"
                "$mod, Space, exec, wofi --show drun"
                "$mod SHIFT, e, exit"
                "$mod SHIFT, L, exec, ${pkgs.hyprlock}/bin/hyprlock"


                # Screen focus
                "$mod, v, togglefloating"
                "$mod, u, focusurgentorlast"
                "$mod, tab, focuscurrentorlast"
                "$mod SHIFT, j, togglesplit"
                "shift, F11, fullscreen"

                # Screen resize
                # "$mod CTRL, h, resizeactive, -20 0"
                # "$mod CTRL, l, resizeactive, 20 0"
                # "$mod CTRL, k, resizeactive, 0 -20"
                # "$mod CTRL, j, resizeactive, 0 20"

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
                # "$mod, h, movefocus, l"
                # "$mod, l, movefocus, r"
                # "$mod, k, movefocus, u"
                # "$mod, j, movefocus, d"

                # Applications
                # "$mod ALT, f, exec, ${pkgs.firefox}/bin/firefox"
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
