{username, hostname, config, pkgs, lib, ...}:

{
  # User configuration
  home.username = username;
  home.homeDirectory = lib.mkForce (builtins.toPath "/Users/${username}");

  # This is internal compatibility configuration 
  # for home-manager, don't change this!
  home.stateVersion = "25.05";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [];

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
    zsh = {
      enable = true;
      # ohMyZsh = {
      #   enable = true;
      #   plugins = [ "git" "thefuck" "zsh-autosuggestions"];
      #   theme = "robbyrussell";
      # };

      shellAliases = {
        update = "sudo darwin-rebuild switch --flake ~/nix-darwin-config";
      };
    };
    neovim = {
      enable = true;
      plugins = [
        pkgs.vimPlugins.LazyVim # Its honestly so cool that this is all we need to do
      ];
    };
  };
}