{...}: {
  flake.modules.nixos.desktop = {
    programs.firefox.enable = true;
  };
}
