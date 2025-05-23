{username, ...}: let
  hostname = "Henrys-MacBook-Pro";
in {
  imports = [
    ../../modules/darwin
    # ../../secrets/darwin.nix
  ];

  # nixpkgs.overlays = import ../../overlays args;

  networking.hostName = hostname;
  networking.computerName = hostname;
  # system.defaults.smb.NetBIOSName = hostname;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    home = "/Users/${username}";
    description = username;
  };

  nix.settings.trusted-users = [username];
}
