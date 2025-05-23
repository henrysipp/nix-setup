{pkgs, ...}: {
  programs.firefox.enable = true;
  programs.vscode.enable = true;

  home.packages = with pkgs; [
    # Graphical
    slack
    tdesktop # telegram desktop
    termite
    vlc
    zed-editor
  ];
}