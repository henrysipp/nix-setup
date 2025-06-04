{...}: {
  flake.modules.homeManager.nvim = {
    home.file = {
      ".config/nvim" = {
        source = ../../../config/nvim;
        recursive = true;
      };
    };
  };
}
