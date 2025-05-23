{pkgs, ...}: {
  programs.firefox.enable = true;
  programs.vscode.enable = true;

  home.packages = with pkgs; [
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
