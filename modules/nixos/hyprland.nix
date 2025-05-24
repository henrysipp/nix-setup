{pkgs, ...}: {
    
    programs.hyprland = {

        enable = true;
        xwayland.enable = true;
        package = pkgs.hyprland;
        withUWSM  = true;
    };
    # environment.sessionVariables = {
    #     WLR_NO_HARDWARE_CURSORS = "1";
    #     NIXOS_OZONE_WL = "1";
    # };

    environment.systemPackages = [
        pkgs.kitty
        pkgs.wofi
    ];

    # wayland.windowManager.hyprland.settings = {
    #     "$mod" = "SUPER";
    # };
} 