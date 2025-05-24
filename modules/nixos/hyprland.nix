{pkgs, ...}: {
    programs.hyprland.enable = true;
    programs.hyprland.xwayland.enable = true;
    programs.hyprland.package = pkgs.hyprland;

    programs.hyprland.withUWSM  = true;


    # environment.sessionVariables = {
    #     WLR_NO_HARDWARE_CURSORS = "1";
    #     NIXOS_OZONE_WL = "1";
    # };

    environment.systemPackages = [
        pkgs.kitty
        pkgs.wofi
    ];
}