{pkgs, ...}: {
  programs.firefox.enable = true;
  programs.vscode.enable = true;

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
  # environment.sessionVariables = {
  #   XCURSOR_THEME = "YourThemeName";
  #   XCURSOR_SIZE = "24";
  # };

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
}
