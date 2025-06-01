{nixpkgs, ...}: {
  flake.modules = {
    nixpkgs.allowedUnfreePackages = ["vscode"];

    nixos.dev = {
    };

    homeManager.dev = {
      programs.vscode.enable = true;
    };
  };
}
