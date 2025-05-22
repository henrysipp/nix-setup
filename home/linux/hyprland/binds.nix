{host, ...}: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      # bind = $mainMod, escape, exit,

      "$mainMod, W, killactive,"
      "$mainMod, Return, exec, $terminal"
      "$mainMod, E, exec, $fileManager"
      "$mainMod, V, togglefloating,"
      "$mainMod, L, exec, $HOME/.config/waybar/launch.sh"
      "$mainMod, P, pseudo, # dwindle"
      "$mainMod, J, togglesplit, # dwindle"
      "$mainMod, Space, exec, $menu"
      "$mainMod, F11, fullscreen"

      # Move focus with mainMod + arrow keysss
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      # Switch workspaces with mainMod + [0-9]
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mainMod,SHIFT, 1, movetoworkspace, 1"
      "$mainMod,SHIFT, 2, movetoworkspace, 2"
      "$mainMod,SHIFT, 3, movetoworkspace, 3"
      "$mainMod,SHIFT, 4, movetoworkspace, 4"
      "$mainMod,SHIFT, 5, movetoworkspace, 5"
      "$mainMod,SHIFT, 6, movetoworkspace, 6"
      "$mainMod,SHIFT, 7, movetoworkspace, 7"
      "$mainMod,SHIFT, 8, movetoworkspace, 8"
      "$mainMod,SHIFT, 9, movetoworkspace, 9"
      "$mainMod,SHIFT, 0, movetoworkspace, 10"

      # Example special workspace (scratchpad)
      "$mainMod , S, togglespecialworkspace, magic"
      "$mainMod SHIFT, S, movetoworkspace, special:magic"

      # bind = $mainMod, F11, exec, wpctl set-volume -1 1 @DEFAULT_AUDIO_SINC@ 5%+
      # bind = $mainMod, F12, exec, wpctl set-volume @DEFAULT_AUDIO_SINC@ 5%-
    ];

    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
  };
}