# Touchpad gestures and click behavior.
{lib, ...}: let
  h = import ../../../lib/hyprland.nix {inherit lib;};
in {
  wayland.windowManager.hyprland.settings = {
    # Framework touchpads send MMB on 3-finger click when clickfinger_behavior is on.
    # Swallow it here so apps never see a middle click from the pad.
    bind = [
      (h.bindFn' "mouse:274" "" {
        mouse = true;
        auto_consuming = true;
      })
    ];

    gesture = [
      (h.gesture {
        fingers = 3;
        direction = "horizontal";
        action = "workspace";
      })
    ];

    config = {
      input.touchpad = {
        natural_scroll = true;
        tap_to_click = true;
        clickfinger_behavior = true;
        middle_button_emulation = false;
      };

      gestures.workspace_swipe_forever = true;
    };
  };
}
