{...}: {
  flake.modules.nixos.desktop = {
    # What to put here?
  };

  flake.modules.homeManager.desktop = {pkgs, ...}: {
    gtk = {
      enable = true;
      cursorTheme = {
        package = pkgs.apple-cursor;
        name = "macOS";
        size = 24;
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
}
