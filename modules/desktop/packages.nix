{inputs, ...}: {
  flake.modules.nixos.desktop = {pkgs, ...}: {
    programs = {
      _1password.enable = true;
      _1password-gui.enable = true;

      # TODO: Dynamically get user names
      _1password-gui.polkitPolicyOwners = ["henry"];

      dconf.enable = true; # Enabled by default in gnome, needed for hyprland
    };

    services.flatpak.enable = true;

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
