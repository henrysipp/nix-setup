{lib, ...}: let
  lua = lib.generators.mkLuaInline;
in {
  # Home Manager turns hyphenated keys like exec-once into invalid Lua
  # (hl.exec-once is parsed as subtraction). Use event hooks instead.
  wayland.windowManager.hyprland.settings.on = [
    {
      _args = [
        "hyprland.start"
        (lua ''
          function()
            hl.exec_cmd("waybar")
          end
        '')
      ];
    }
    {
      _args = [
        "config.reloaded"
        (lua ''
          function()
            hl.exec_cmd("pkill -SIGUSR2 waybar || waybar")
          end
        '')
      ];
    }
  ];
}
