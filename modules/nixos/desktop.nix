{
  pkgs,
  inputs,
  lib,
  flake-inputs,
  host,
  ...
}: let 
in{
  imports = [
    ./common.nix
  ];

  nixpkgs.config.allowUnfree = lib.mkForce true;
  boot.loader.systemd-boot.configurationLimit = lib.mkDefault 5;
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };

  environment.variables.EDITOR = "nvim";
  environment.shells = with pkgs; [
    bash
    zsh
  ];

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      fira-code
      fira-code-symbols
      nerd-fonts.fira-code
    ];
    
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "FiraCode Nerd Font" ];
      };
    };
  };

  # services.flatpak.enable = true;
  # services.flatpak.packages = [
  #   "net.davidotek.pupgui1"
  # ];

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
}
