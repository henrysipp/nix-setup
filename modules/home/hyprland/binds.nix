{lib, ...}: let
  h = import ../../../lib/hyprland.nix {inherit lib;};
in {
  wayland.windowManager.hyprland.settings.bind =
    [
      (h.bindGlobal "SUPER + Space" "quickshell:launcher")
      (h.bind "SUPER + W" "hl.dsp.window.close()")
      (h.bindExec "SUPER + RETURN" "ghostty")
      (h.bindShortcutOnce "SUPER + C" "CTRL" "C")
      (h.bindShortcutOnce "SUPER + V" "CTRL" "V")
      (h.bindShortcutOnce "SUPER + X" "CTRL" "X")
      (h.bindExec "SUPER + CTRL + V" "walker -m clipboard")
      (h.bind "SUPER + F" ''hl.dsp.window.fullscreen({ action = "toggle" })'')
      (h.bindFn "SUPER + SHIFT + BACKSPACE" ''
        local state = rawget(_G, "_hokum_gaps") or { on = true }
        _G._hokum_gaps = state
        if state.on then
          hl.config({
            general = { gaps_in = 0, gaps_out = 0 },
            decoration = { rounding = 0 },
          })
          state.on = false
        else
          hl.config({
            general = { gaps_in = ${toString h.gapInner}, gaps_out = ${toString h.gapOuter} },
            decoration = { rounding = ${toString h.rounding} },
          })
          state.on = true
        end
      '')
      (h.bindFn "SUPER + L" ''
        local layout = hl.get_config("general.layout")
        if layout == "scrolling" then
          hl.config({ general = { layout = "dwindle" } })
        else
          hl.config({ general = { layout = "scrolling" } })
        end
      '')
      (h.bind "SUPER + J" ''hl.dsp.layout("togglesplit")'')
      (h.bind "SUPER + minus" ''hl.dsp.window.resize({ x = -100, y = 0, relative = true })'')
      (h.bind "SUPER + equal" ''hl.dsp.window.resize({ x = 100, y = 0, relative = true })'')
      (h.bind "SUPER + SHIFT + minus" ''hl.dsp.window.resize({ x = 0, y = -100, relative = true })'')
      (h.bind "SUPER + SHIFT + equal" ''hl.dsp.window.resize({ x = 0, y = 100, relative = true })'')
      (h.bind "SUPER + SHIFT + B" "hl.dsp.exec_cmd(browser)")
      (h.bind "SUPER + SHIFT + F" "hl.dsp.exec_cmd(fileManager)")
      (h.bind "SUPER + SHIFT + slash" "hl.dsp.exec_cmd(passwordManager)")
      (h.bind' {
        key = "SUPER + mouse:272";
        dispatch = "hl.dsp.window.drag()";
        opts = {mouse = true;};
      })
      (h.bind' {
        key = "SUPER + mouse:273";
        dispatch = "hl.dsp.window.resize()";
        opts = {mouse = true;};
      })
      (h.bindExec' "XF86AudioRaiseVolume" "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+" h.lockedRepeating)
      (h.bindExec' "XF86AudioLowerVolume" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-" h.lockedRepeating)
      (h.bindExec' "XF86AudioMute" "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" h.lockedRepeating)
      (h.bindExec' "XF86AudioMicMute" "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle" h.lockedRepeating)
      (h.bindExec' "XF86MonBrightnessUp" "brightnessctl -n2 set 5%+" h.lockedRepeating)
      (h.bindExec' "XF86MonBrightnessDown" "brightnessctl -n2 set 5%-" h.lockedRepeating)
      (h.bindExec' "XF86AudioNext" "playerctl next" h.locked)
      (h.bindExec' "XF86AudioPause" "playerctl play-pause" h.locked)
      (h.bindExec' "XF86AudioPlay" "playerctl play-pause" h.locked)
      (h.bindExec' "XF86AudioPrev" "playerctl previous" h.locked)
    ]
    ++ h.arrowBinds
    ++ (h.workspaceBinds 5);
}
