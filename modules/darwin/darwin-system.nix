{...}: {
  flake.modules.darwin.system = {
    system = {
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
    };
  };
}