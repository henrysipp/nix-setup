{host, ...}: {
  wayland.windowManager.hyprland.settings = {
    # bind = [
    #   # bind = $mainMod,escape,exit,

    #   "$modifier,W,killactive,"
    #   "$modifier,Return,exec,kitty"
    #   "$modifier,E,exec,$fileManager"
    #   "$modifier,V,togglefloating,"
    #   "$modifier,L,exec,$HOME/.config/waybar/launch.sh"
    #   "$modifier,P,pseudo,# dwindle"
    #   "$modifier,J,togglesplit,# dwindle"
    #   "$modifier,Space,exec,$menu"
    #   "$modifier,F11,fullscreen"

    #   # Move focus with mainMod + arrow keysss
    #   "$modifier,left,movefocus,l"
    #   "$modifier,right,movefocus,r"
    #   "$modifier,up,movefocus,u"
    #   "$modifier,down,movefocus,d"

    #   # Switch workspaces with mainMod + [0-9]
    #   "$modifier,1,workspace,1"
    #   "$modifier,2,workspace,2"
    #   "$modifier,3,workspace,3"
    #   "$modifier,4,workspace,4"
    #   "$modifier,5,workspace,5"
    #   "$modifier,6,workspace,6"
    #   "$modifier,7,workspace,7"
    #   "$modifier,8,workspace,8"
    #   "$modifier,9,workspace,9"
    #   "$modifier,0,workspace,10"

    #   # Move active window to a workspace with mainMod + SHIFT + [0-9]
    #   "$modifier SHIFT,1,movetoworkspace,1"
    #   "$modifier SHIFT,2,movetoworkspace,2"
    #   "$modifier SHIFT,3,movetoworkspace,3"
    #   "$modifier SHIFT,4,movetoworkspace,4"
    #   "$modifier SHIFT,5,movetoworkspace,5"
    #   "$modifier SHIFT,6,movetoworkspace,6"
    #   "$modifier SHIFT,7,movetoworkspace,7"
    #   "$modifier SHIFT,8,movetoworkspace,8"
    #   "$modifier SHIFT,9,movetoworkspace,9"
    #   "$modifier SHIFT,0,movetoworkspace,10"

    #   # Example special workspace (scratchpad)
    #   "$modifier,S,togglespecialworkspace,magic"
    #   "$modifier SHIFT,S,movetoworkspace,special:magic"

    #   # bind = $mainMod,F11,exec,wpctl set-volume -1 1 @DEFAULT_AUDIO_SINC@ 5%+
    #   # bind = $mainMod,F12,exec,wpctl set-volume @DEFAULT_AUDIO_SINC@ 5%-
    # ];

    # bindm = [
    #   "$modifier,mouse:272,movewindow"
    #   "$modifier,mouse:273,resizewindow"
    # ];
  };
}
