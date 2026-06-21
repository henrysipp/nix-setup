# Media and brightness keys from omarchy-nix hyprland/bindings.nix (bindl/bindel).
{lib, ...}: let
  lua = lib.generators.mkLuaInline;

  execBind = key: cmd: opts: {
    _args = [
      key
      (lua ''hl.dsp.exec_cmd("${cmd}")'')
      opts
    ];
  };

  lockedRepeating = {
    locked = true;
    repeating = true;
  };

  lockedOnly = {
    locked = true;
  };
in {
  wayland.windowManager.hyprland.settings.bind = [
    (execBind "XF86AudioRaiseVolume" "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+" lockedRepeating)
    (execBind "XF86AudioLowerVolume" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-" lockedRepeating)
    (execBind "XF86AudioMute" "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" lockedRepeating)
    (execBind "XF86AudioMicMute" "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle" lockedRepeating)
    (execBind "XF86MonBrightnessUp" "brightnessctl -e4 -n2 set 5%+" lockedRepeating)
    (execBind "XF86MonBrightnessDown" "brightnessctl -e4 -n2 set 5%-" lockedRepeating)
    (execBind "XF86AudioNext" "playerctl next" lockedOnly)
    (execBind "XF86AudioPause" "playerctl play-pause" lockedOnly)
    (execBind "XF86AudioPlay" "playerctl play-pause" lockedOnly)
    (execBind "XF86AudioPrev" "playerctl previous" lockedOnly)
  ];
}
