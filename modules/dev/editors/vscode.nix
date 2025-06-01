{
  inputs,
  lib,
  ...
}: {
  flake.modules = {
    nixos.dev = {
    };

    home-manager.dev = {
      programs.vscode.enable = true;
    };
  };
}
