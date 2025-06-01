{pkgs, ...}: {
  programs = {
    _1password-gui.enable = true;
    dconf.enable = true; # Enabled by default in gnome, needed for hyprland
    firefox.enable = true;
  };

  environment.systemPackages = with pkgs; [
    alejandra
    brightnessctl
    curl
    cifs-utils
    ffmpeg
    gh
    git
    gnumake
    htop
    killall
    neofetch
    neovim
    pavucontrol
    ripgrep
    vscode
    wget
  ];
}
