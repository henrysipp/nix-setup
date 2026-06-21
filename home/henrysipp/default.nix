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

  # Static files under files/ are deployed into $HOME with the same layout.
  home.file."Pictures/Wallpapers" = {
    source = ./files/Pictures/Wallpapers;
    recursive = true;
  };
}
