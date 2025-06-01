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
  programs.kitty.enable = true;
}
