{...}: {
  programs.home-manager.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      identityAgent = "~/.1password/agent.sock";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      credential.helper = "store";
      user.email = "hesipp@gmail.com";
      user.name = "Henry Sipp";
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  xdg.configFile."direnv/direnv.toml".text = ''
    [global]
    hide_env_diff = true
    log_format = "-"
  '';

  programs.zsh.enable = true;
  programs.zsh.oh-my-zsh = {
    enable = true;
    theme = "robbyrussell";
  };
  programs.zsh.envExtra = ''
    export DIRENV_LOG_FORMAT=""
  '';
}
