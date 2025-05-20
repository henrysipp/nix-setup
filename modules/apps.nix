{ pkgs, ...}: 
{

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ 
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
      "nikitabobko/aerospace" 
    ];
    brews = [ 
      "sapling" # Looks like nix version is very outdated, mayhaps learn how to update and PR?
    ];
    casks = [ 
      "1password"
      "ghostty"
      "docker"
      "sublime-text"
      # "claude"
      "jetbrains-toolbox"
      "visual-studio-code"

      "nikitabobko/tap/aerospace"
    ];
  };
}