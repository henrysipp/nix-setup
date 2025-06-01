{pkgs, ...}: {
  flake.modules = {
    nixos.desktop = {
      # What to put here?
    };

    home-manager.desktop = {
      gtk = {
        enable = true;
        cursorTheme = {
          package = pkgs.apple-cursor;
          name = "macOS";
          size = 24;
          # package = pkgs.bibata-cursors;
          # name = "Bibata Modern Ice";
        };
      };

      home.sessionVariables = {
        XCURSOR_THEME = "macOS";
        XCURSOR_SIZE = "24";
      };

      home.packages = with pkgs; [
        apple-cursor

        # media
        vlc
        flameshot

        # development
        vscode
        zed-editor
        alacritty

        # comms
        discord
        tdesktop # telegram

        # gaming
        flatpak
        protonup-qt
      ];
    };
  };
}
