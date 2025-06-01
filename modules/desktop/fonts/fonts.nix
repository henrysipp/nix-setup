{pkgs, ...}: {
  flake.modules = {
    nixos.desktop = {pkgs, ...}: {
      fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-emoji
        fira-code
        fira-code-symbols
        nerd-fonts.fira-code
      ];

      fonts.fontconfig = {
        enable = true;
        defaultFonts = {
          serif = ["Noto Serif"];
          sansSerif = ["Noto Sans"];
          monospace = ["FiraCode Nerd Font"];
        };
      };
    };

    homeManager.desktop = {
      fonts.fontconfig.enable = true;
    };
  };
}
