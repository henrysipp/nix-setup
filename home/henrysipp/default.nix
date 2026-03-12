{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../modules/home
  ];

  home.username = "henrysipp";
  home.homeDirectory = "/home/henrysipp";
  home.stateVersion = "25.05";

  # Keep user-specific overrides in this file.
}
