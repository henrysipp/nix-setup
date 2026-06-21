# Touchpad gestures and click behavior.
{lib, ...}: let
  lua = lib.generators.mkLuaInline;
in {
  wayland.windowManager.hyprland.settings = {
    # Framework touchpads send MMB on 3-finger click when clickfinger_behavior is on.
    # Swallow it here so apps never see a middle click from the pad.
    bind = [
      {
        _args = [
          "mouse:274"
          (lua "function() end")
          {
            mouse = true;
            auto_consuming = true;
          }
        ];
      }
    ];

    gesture = [
      {
        _args = [
          {
            fingers = 3;
            direction = "horizontal";
            action = "workspace";
          }
        ];
      }
    ];

    config = {
      input = {
        touchpad = {
          natural_scroll = true;
          tap_to_click = true;
          clickfinger_behavior = true;
          middle_button_emulation = false;
        };
      };

      gestures = {
        workspace_swipe_forever = true;
      };
    };
  };
}
