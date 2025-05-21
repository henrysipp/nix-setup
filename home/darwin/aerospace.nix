{config, ...}: {
  home.file = {
    ".aerospace.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink ../../config/aerospace.toml;
    };
  };
}
