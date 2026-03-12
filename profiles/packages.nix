{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Base system tools
    git
    vim
    brightnessctl
    ffmpeg
    alejandra
    bibata-cursors
    gnome-themes-extra

    # Shell tools
    fzf
    zoxide
    ripgrep
    eza
    fd
    curl
    unzip
    wget
    gnumake

    # TUIs
    lazygit
    lazydocker
    btop
    powertop
    fastfetch

    # GUIs
    chromium
    firefox
    obsidian
    vlc

    # Can't find this in nixpkgs!
    # Might have to make it ourselves
    # asdcontrol

    # Don't want these right now
    # obs-studio
    # kdePackages.kdenLive
    # pinta
    # libreoffice
    # signal-desktop

    # Commercial GUIs
    typora
    dropbox
    spotify
    _1password-gui
    # zoom

    # Development tools
    github-desktop
    gh
    codex

    # Containers
    docker-compose
    # podman-compose
  ];
}
