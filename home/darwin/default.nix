{
  pkgs,
  username,
  ...
}: {
  imports = [
    ../base
    ./core.nix
    ./aerospace.nix
  ];

  home = {
    username = username;
    homeDirectory = "/Users/${username}";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "25.05";
  };

  programs = {
    # neovim = {
    #   enable = true;
    #   plugins = [
    #     pkgs.vimPlugins.LazyVim
    #   ];
    # };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
