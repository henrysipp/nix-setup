{
  pkgs,
  osConfig,
  ...
}: {
  # only available on linux, disabled on macos
  services.ssh-agent.enable = pkgs.stdenv.isLinux;

  home.packages =
    [pkgs.ripgrep]
    ++ (
      # you can access the host configuration using osConfig.
      pkgs.lib.optionals (osConfig.programs.vim.enable && pkgs.stdenv.isDarwin) [
        # pkgs.skhd
      ]
    );

  # programs.git = {
  #   enable = true;
  #   userName = userfullname;
  #   userEmail = useremail;
  # };

  programs.lazygit.enable = true;
  programs.starship.enable = true;
  programs.zellij.enable = true;
  programs.kitty.enable = true;
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
}
