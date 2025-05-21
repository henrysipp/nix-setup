{...}: {
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
        # { name = "thefuck"; }
        {
          name = "fdellwing/zsh-bat";
          tags = [as:command];
        }
      ];
      # theme = "robbyrussell";
    };
    sessionVariables = {
      EDITOR = "nvim";
    };
    shellAliases = {
      update = "sudo darwin-rebuild switch --flake ~/nix-darwin-config";
      nix-gc = "nix-env --delete-generations +3";
    };
  };
}
