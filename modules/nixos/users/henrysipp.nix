{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hokum.users.henrysipp.enable = lib.mkEnableOption "the primary henrysipp user account and home-manager config";

  config = lib.mkIf config.hokum.users.henrysipp.enable {
    users.users.henrysipp = {
      isNormalUser = true;
      initialPassword = "changeme";
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [];

      extraGroups = [
        "audio"
        "input"
        "networkmanager"
        "sound"
        "tty"
        "wheel"
        "docker"
      ];
    };

    home-manager.users.henrysipp = {
      imports = [
        ../../../home/henrysipp
      ];
    };
  };
}
