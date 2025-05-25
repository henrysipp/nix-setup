{pkgs, ...}: {
  programs.firefox.enable = true;
  programs.vscode.enable = true;

  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.apple-cursor;
      name = "macOS-BigSur";
      size = 24;
      # package = pkgs.bibata-cursors;
      # name = "Bibata Modern Ice";
    };
  };

  home.packages = with pkgs; [
    apple-cursor
    tdesktop
    vlc
    zed-editor
    protonup-qt
    alacritty
    flameshot
    vscode
    discord
  ];
}
