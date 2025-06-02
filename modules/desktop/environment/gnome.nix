{...}: {
  flake.modules.nixos.desktop = {pkgs, ...}: {
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome = {
      enable = true;
      # extraGSettingsOverridePackages = [ pkgs.gnome-settings-daemon ];
      extraGSettingsOverrides = ''
        # GNOME Desktop Keybindings Configuration
        # Load with: dconf load / < this_file.conf

        [org/gnome/desktop/wm/keybindings]
        # Alt+F4 is very cumbersome
        close=['<Super>w']
        # Make it easy to maximize like you can fill left/right
        maximize=['<Super>Up']
        # Make it easy to resize undecorated windows
        begin-resize=['<Super>BackSpace']
        # Full-screen with title/navigation bar
        toggle-fullscreen=['<Shift>F11']
        # Use super for workspaces
        switch-to-workspace-1=['<Super>1']
        switch-to-workspace-2=['<Super>2']
        switch-to-workspace-3=['<Super>3']
        switch-to-workspace-4=['<Super>4']
        switch-to-workspace-5=['<Super>5']
        switch-to-workspace-6=['<Super>6']

        # Move app to workspace with Super+Shift+Number
        move-to-workspace-1=['<Super><Shift>1']
        move-to-workspace-2=['<Super><Shift>2']
        move-to-workspace-3=['<Super><Shift>3']
        move-to-workspace-4=['<Super><Shift>4']

        # Clear input source switching to make room for ulauncher
        switch-input-source=@as []

        [org/gnome/shell/keybindings]
        # Use alt for pinned apps
        switch-to-application-1=['<Alt>1']
        switch-to-application-2=['<Alt>2']
        switch-to-application-3=['<Alt>3']
        switch-to-application-4=['<Alt>4']
        switch-to-application-5=['<Alt>5']
        switch-to-application-6=['<Alt>6']
        switch-to-application-7=['<Alt>7']
        switch-to-application-8=['<Alt>8']
        switch-to-application-9=['<Alt>9']

      '';
    };

    # Disable indexing service to save power
    services.gnome.localsearch.enable = false;
    services.libinput.enable = true;

    environment.systemPackages = with pkgs; [
      gnome-tweaks
      gnome-settings-daemon

      gnomeExtensions.extension-list
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
