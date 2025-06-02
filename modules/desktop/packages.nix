{...}: {
  flake.modules.nixos.desktop = {pkgs, ...}: {
    programs = {
      _1password-gui.enable = true;
      # dconf.enable = true; # Enabled by default in gnome, needed for hyprland
    };

    environment.systemPackages = with pkgs; [
      brightnessctl
      cifs-utils
      ffmpeg
      htop
      killall
      neofetch
      pavucontrol
    ];
  };
}
