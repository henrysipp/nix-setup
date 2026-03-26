{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hokum.packages.enable = lib.mkEnableOption "base workstation package set";

  config = lib.mkIf config.hokum.packages.enable {
    environment.systemPackages = with pkgs; [
      git
      vim
      brightnessctl
      ffmpeg
      alejandra
      bibata-cursors
      gnome-themes-extra
      fzf
      zoxide
      ripgrep
      eza
      fd
      curl
      unzip
      wget
      gnumake
      lazygit
      lazydocker
      btop
      powertop
      fastfetch
      chromium
      firefox
      jetbrains-toolbox
      obsidian
      slack
      vlc
      typora
      dropbox
      spotify
      github-desktop
      gh
      codex
      docker-compose
    ];
  };
}
