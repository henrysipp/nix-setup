{pkgs, ...}: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.neofetch
    pkgs.fnm
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
      "nikitabobko/tap"
      "tuist/tuist"
    ];
    brews = [
      "sapling" # Looks like nix version is very outdated, mayhaps learn how to update and PR?
      "tailscale"

      "tuist/tuist/tuist@4.20.0"
      "awscli"
      "swiftformat"
      "swiftlint"
      "lefthook"
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
}
