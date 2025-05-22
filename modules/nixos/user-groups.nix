{username, ...}: {
  users.groups = {
    "${username}" = {};
    docker = {};
  };

  users.users."${username}" = {
    isNormalUser = true;
    description = username;
    extraGroups = ["networkmanager" "wheel"];
  };
}
