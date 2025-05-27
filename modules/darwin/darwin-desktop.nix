{
  pkgs,
  lib,
  ...
}: {
  nixpkgs.config.allowUnfree = lib.mkForce true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.neofetch
  ];

  # Add homebrew package management
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall"; # This makes homebrew declarative!
      upgrade = true;
    };
    taps = [
      # "tuist/tuist"
    ];
    brews = [
      "sapling" # Looks like nix version is very outdated, mayhaps learn how to update and PR?
      "tailscale"

      # "tuist/tuist/tuist@4.20.0"
      # "awscli"
      # "swiftformat"
      # "swiftlint"
      # "lefthook"
    ];
    casks = [
      "1password"
      "ghostty"
      "docker"
      "spotify"
      "sublime-text"
      "claude"
      "jetbrains-toolbox"
      "visual-studio-code"

      "aerospace"
    ];
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;
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

    # Used for backwards compatibility, please read the changelog before changing.
    stateVersion = 6;
  };
}
