{
  pkgs,
  inputs,
  lib,
  flake-inputs,
  host,
  ...
}: {
  imports = [
    inputs.self.modules.core.henry
    inputs.self.modules.core.fonts
    inputs.self.modules.core.network
    inputs.self.modules.core.nvidia
    inputs.self.modules.core.packages
    inputs.self.modules.core.security
    inputs.self.modules.core.services
    inputs.self.modules.core.steam

    # ./core.henry
    # ./core.fonts
    # ./core.network
    # ./core.nvidia
    # ./core.packages
    # ./core.security
    # ./core.services
    # ./core.steam
  ];

  boot.loader.systemd-boot.configurationLimit = lib.mkDefault 5;
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };

  time.timeZone = "America/Chicago";

  environment.variables.EDITOR = "nvim";
  environment.shells = with pkgs; [
    bash
    zsh
  ];
}
