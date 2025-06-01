{...}: {
  flake.modules.nixos.base = {
    rtkit.enable = true;
  };
}
