{...}: {
  flake.modules.nixos.desktop = {pkgs, ...}: {
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    # Configure dconf settings using the proper NixOS module
    programs.dconf = {
      enable = true;
      profiles.user.databases = [
        {
          lockAll = false; # Allow users to override these settings
          settings = {
            "org/gnome/desktop/interface" = {
              color-scheme = "prefer-dark";
              clock-format = "12h";
              clock-show-weekday = true;
            };
            "org/gnome/desktop/peripherals/touchpad" = {
              "speed" = 0.25;
              "natural-scroll" = true;
            };
            # GNOME Desktop Keybindings Configuration
            "org/gnome/desktop/wm/keybindings" = {
              # Alt+F4 is very cumbersome
              close = ["<Super>w"];
              # Make it easy to maximize like you can fill left/right
              maximize = ["<Super>Up"];
              # Make it easy to resize undecorated windows
              begin-resize = ["<Super>BackSpace"];
              # Full-screen with title/navigation bar
              toggle-fullscreen = ["<Shift>F11"];
              # Use super for workspaces
              switch-to-workspace-1 = ["<Super>1"];
              switch-to-workspace-2 = ["<Super>2"];
              switch-to-workspace-3 = ["<Super>3"];
              switch-to-workspace-4 = ["<Super>4"];
              switch-to-workspace-5 = ["<Super>5"];
              switch-to-workspace-6 = ["<Super>6"];
              # Move app to workspace with Super+Shift+Number
              move-to-workspace-1 = ["<Super><Shift>1"];
              move-to-workspace-2 = ["<Super><Shift>2"];
              move-to-workspace-3 = ["<Super><Shift>3"];
              move-to-workspace-4 = ["<Super><Shift>4"];
              # Clear input source switching to make room for ulauncher
              # switch-input-source = lib.mkEmptyArray;
            };
            "org/gnome/shell/keybindings" = {
              # Use alt for pinned apps
              switch-to-application-1 = ["<Alt>1"];
              switch-to-application-2 = ["<Alt>2"];
              switch-to-application-3 = ["<Alt>3"];
              switch-to-application-4 = ["<Alt>4"];
              switch-to-application-5 = ["<Alt>5"];
              switch-to-application-6 = ["<Alt>6"];
              switch-to-application-7 = ["<Alt>7"];
              switch-to-application-8 = ["<Alt>8"];
              switch-to-application-9 = ["<Alt>9"];
            };
            # Application workspace assignments
            "org/gnome/shell/app-switcher" = {
              current-workspace-only = false;
            };
            # Workspace assignments for specific applications
            "org/gnome/desktop/wm/preferences" = {
              workspace-names = ["Web" "Development" "Gaming" "General"];
            };
          };
        }
        {
          # Application-specific workspace assignments
          lockAll = false;
          settings = {
            # Firefox to workspace 1
            "org/gnome/shell/extensions/auto-move-windows" = {
              application-list = [
                "firefox.desktop:1"
                "code.desktop:2"
                "webstorm.desktop:2"
                "Alacritty.desktop:2"
                "steam.desktop:3"
                "discord.desktop:3"
              ];
            };
          };
        }
      ];
    };
    # Disable indexing service to save power
    services.gnome.localsearch.enable = false;
    services.libinput.enable = true;
    environment.systemPackages = with pkgs; [
      gnome-tweaks
      gnome-settings-daemon
      gnomeExtensions.extension-list
      gnomeExtensions.auto-move-windows # Required for workspace assignments
    ];
    environment.gnome.excludePackages = with pkgs; [
      orca
      evince
      geary
      gnome-tour
      gnome-user-docs
      gnome-text-editor
      gnome-calculator
      gnome-calendar
      gnome-console
      gnome-contacts
      gnome-music
      gnome-weather
      simple-scan
      yelp
    ];
  };
}
