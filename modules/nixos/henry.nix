{
  inputs,
  pkgs,
  ...
}: {
  users.users.henry = {
    uid = 1000;
    description = "Henry Sipp";

    isNormalUser = true;

    extraGroups = [
      "audio"
      "input"
      "networkmanager"
      "sound"
      "tty"
      "video"
      "wheel"
    ];

    hashedPassword = "$y$j9T$guKKxlVyFoz3UznhYlNLZ/$IS66tZuuPXa9kClWh83ugZNoo.WEWRt/KMcTJomqmR.";

    # packages = [ inputs.self.packages.${pkgs.system}.myvim ];

    # shell = "/run/current-system/sw/bin/bash";
  };
}
