{ ... }: {
  programs.home-manager.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = true;
  };

  programs.git = {
    enable = true;
    settings = {
      credential.helper = "store";
    };
    userEmail = "hesipp@gmail.com";
    userName = "Henry Sipp";
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
}
