{username, hostname, config, pkgs, lib, ...}:

{
  # User configuration
  home.username = username;
  home.homeDirectory = lib.mkForce (builtins.toPath "/Users/${username}");

  # This is internal compatibility configuration 
  # for home-manager, don't change this!
  home.stateVersion = "25.05";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
  ];

  # Environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let home-manager install and manage itself.
  programs.home-manager.enable = true;

  programs = {
    git = {
      enable = true;
      userName = "Henry Sipp";
      userEmail = "hesipp@gmail.com";
    };
    starship = {
      enable = true;
      # Configuration written to ~/.config/starship.toml
      settings = {
        # add_newline = false;
      };
    };
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      zplug = {
        enable = true;
        plugins = [ 
          { name = "plugins/git"; tags = [ from:oh-my-zsh ]; }
          # { name = "thefuck"; } 
          { name = "fdellwing/zsh-bat"; tags = [ as:command ]; }
        ];
        # theme = "robbyrussell";
      };

      shellAliases = {
        update = "sudo darwin-rebuild switch --flake ~/nix-darwin-config";
        nix-gc = "nix-env --delete-generations +3";
      };
    };
    neovim = {
      enable = true;
      plugins = [
        pkgs.vimPlugins.LazyVim 
      ];
    };
  };
}