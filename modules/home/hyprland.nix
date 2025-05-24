{pkgs, ...}: {

    home.packages = [
        pkgs.kitty
        pkgs.wofi
    ];

    wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        systemd.enable = true;

        settings = {
            "$terminal" = "alacritty";
        };
    };
}