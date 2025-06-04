{...}: {
  flake.modules.homeManager.dev = {
    programs.git = {
      enable = true;
      userName = "Henry Sipp";
      userEmail = "hesipp@gmail.com";
    };
  };
}
