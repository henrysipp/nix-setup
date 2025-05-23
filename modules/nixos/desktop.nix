{pkgs, inputs, lib, flake-inputs, ...}: {
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

  # services.flatpak.enable = true;
  # services.flatpak.packages = [
  #   "net.davidotek.pupgui1"
  # ];

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
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
