{...}: {
  flake.modules = {
    nixos.shell = {
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
        shellAliases = {
          update = "sudo darwin-rebuild switch --flake ~/nix-darwin-config";
          nix-gc = "nix-env --delete-generations +3";
        };
      };
    };
  };
}
