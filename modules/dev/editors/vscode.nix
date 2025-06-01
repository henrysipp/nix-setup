{
  inputs,
  lib,
  ...
}: {
  flake.modules.nixos.dev = {
  };

  flake.modules.home-manager.dev = {
    programs.vscode.enable = true;
  };
}
