{ config, ... }: {
  programs.home-manager.enable = true;

  # home.sessionVariables = {
  #   # Prefer 1Password's agent over gcr so SSH doesn't fall back to askpass.
  #   SSH_AUTH_SOCK = "${config.home.homeDirectory}/.1password/agent.sock";
  # };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = true;
    extraConfig = ''
      Host *
          IdentityAgent ~/.1password/agent.sock
    '';
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
