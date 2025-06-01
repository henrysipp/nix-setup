{config, ...}: {
  flake = {
    meta.users = {
      henry = {
        email = "henry.sipp@hey.com";
        name = "Henry Sipp";
        username = "henrysipp";
      };
    };

    modules.nixosUsers.henry = {pkgs, ...}: {
      users.users.henry = {
        description = config.flake.meta.users.henry.name;
        isNormalUser = true;
        createHome = true;
        extraGroups = [
          "audio"
          "input"
          "networkmanager"
          "sound"
          "tty"
          "wheel"
        ];

        hashedPassword = "$y$j9T$guKKxlVyFoz3UznhYlNLZ/$IS66tZuuPXa9kClWh83ugZNoo.WEWRt/KMcTJomqmR.";
      };
    };
  };
}
