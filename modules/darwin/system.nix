{pkgs, ...}: {
  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    primaryUser = "henry";
    defaults = {
      dock = {
        autohide = true; # automatically hide and show the dock
        show-recents = false; # do not show recent apps in dock
        # do not automatically rearrange spaces based on most recent use.
        mru-spaces = false;
      };

      finder = {
        # _FXShowPosixPathInTitle = true; # show full path in finder title
        # AppleShowAllExtensions = true; # show all file extensions
        FXEnableExtensionChangeWarning = false; # disable warning when changing file extension
        # ShowPathbar = true; # show path bar
        # ShowStatusBar = true; # show status bar
      };

      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
      };

      # keyboard = {
      #   enableKeyMapping = true;
      #   remapCapsLockToControl = true;
      # };
    };

    # Used for backwards compatibility, please read the changelog before changing.
    stateVersion = 6;
  };
}
