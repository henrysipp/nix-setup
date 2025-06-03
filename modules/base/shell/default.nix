{...}: {
  flake.modules = {
    nixos.shell = {pkgs, ...}: {
    };

    darwin.shell = {pkgs, ...}: {
    };

    homeManager.shell = {
      programs.direnv.enable = true;
      programs.starship.enable = true;
      programs.zellij.enable = true;
      programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        zplug = {
          enable = true;
          plugins = [
            {
              name = "plugins/git";
              tags = [from:oh-my-zsh];
            }
            {
              name = "fdellwing/zsh-bat";
              tags = [as:command];
            }
          ];
        };
        sessionVariables = {
          EDITOR = "nvim";
        };
      };
    };
  };
}
