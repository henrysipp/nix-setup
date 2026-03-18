{inputs, pkgs, ...}: {
  users.users = {
    henrysipp = {
      isNormalUser = true;
      initialPassword = "changeme";
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
      ];

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
  };
}
