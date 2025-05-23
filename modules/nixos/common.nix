{ flake, pkgs, inputs, ...}: {

  imports = [
    ./henry.nix
    inputs.home-manager.nixosModules.default
  ];

  # nix-flatpak.nixosModules.nix-flatpak
  environment.systemPackages = with pkgs; [
    kitty
    vscode
    neovim
    wget
    curl
    git
    alacritty
    flameshot
    git
    neofetch
    gh
    gnumake
    discord
  ];



  programs = {
    firefox = {enable = true;};
    steam = {
      enable = true;
    };
    _1password-gui = {
      enable = true;
    };
  };
}
