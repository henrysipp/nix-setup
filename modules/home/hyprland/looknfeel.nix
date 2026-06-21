# Omarchy look and feel; colors from the active desktop theme.
{config, lib, ...}: let
  h = import ../../../lib/hyprland.nix {inherit lib;};
  theme = import ../../../lib/hyprland-theme.nix {colors = config.hokum.theme.colors;};
in {
  wayland.windowManager.hyprland.settings = {
    config = {
      general = {
        gaps_in = h.gapInner;
        gaps_out = h.gapOuter;
        border_size = 0;
        col = {
          active_border = theme.activeBorderColor;
          inactive_border = theme.inactiveBorderColor;
        };
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = theme.rounding;
        shadow = {
          enabled = true;
          range = 2;
          render_power = 3;
          color = theme.shadowColor;
        };
        blur = {
          enabled = true;
          size = 2;
          passes = 2;
          special = true;
          brightness = 0.60;
          contrast = 0.75;
        };
      };

      group = {
        col = {
          border_active = theme.activeBorderColor;
          border_inactive = theme.inactiveBorderColor;
        };
        groupbar = {
          font_size = 12;
          font_family = "monospace";
          font_weight_active = "ultraheavy";
          font_weight_inactive = "normal";
          indicator_height = 0;
          indicator_gap = 5;
          height = 22;
          gaps_in = 5;
          gaps_out = 0;
          text_color = "rgb(ffffff)";
          text_color_inactive = "rgba(ffffff90)";
          col = {
            active = "rgba(00000040)";
            inactive = "rgba(00000020)";
          };
          gradients = true;
          gradient_rounding = 0;
          gradient_round_only_edges = false;
        };
      };

      animations.enabled = true;

      dwindle = {
        preserve_split = true;
        force_split = 2;
      };

      scrolling.column_width = 0.49;

      master.new_status = "master";

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        disable_scale_notification = true;
        middle_click_paste = false;
        focus_on_activate = true;
        anr_missed_pings = 3;
        on_focus_under_fullscreen = 1;
      };

      cursor = {
        hide_on_key_press = true;
        warp_on_change_workspace = 1;
      };

      binds.hide_special_on_workspace_change = true;
    };

    curve = h.curves [
      {
        name = "easeOutQuint";
        points = [
          [
            0.23
            1
          ]
          [
            0.32
            1
          ]
        ];
      }
      {
        name = "easeInOutCubic";
        points = [
          [
            0.65
            0.05
          ]
          [
            0.36
            1
          ]
        ];
      }
      {
        name = "linear";
        points = [
          [
            0
            0
          ]
          [
            1
            1
          ]
        ];
      }
      {
        name = "almostLinear";
        points = [
          [
            0.5
            0.5
          ]
          [
            0.75
            1.0
          ]
        ];
      }
      {
        name = "quick";
        points = [
          [
            0.15
            0
          ]
          [
            0.1
            1
          ]
        ];
      }
    ];

    animation = h.animations [
      {
        leaf = "global";
        speed = 10;
      }
      {
        leaf = "border";
        speed = 5.39;
        bezier = "easeOutQuint";
      }
      {
        leaf = "windows";
        speed = 3.79;
        bezier = "easeOutQuint";
      }
      {
        leaf = "windowsIn";
        speed = 4.1;
        bezier = "easeOutQuint";
        style = "popin 87%";
      }
      {
        leaf = "windowsOut";
        speed = 1.49;
        bezier = "linear";
        style = "popin 87%";
      }
      {
        leaf = "fadeIn";
        speed = 1.73;
        bezier = "almostLinear";
      }
      {
        leaf = "fadeOut";
        speed = 1.46;
        bezier = "almostLinear";
      }
      {
        leaf = "fade";
        speed = 3.03;
        bezier = "quick";
      }
      {
        leaf = "layers";
        speed = 3.81;
        bezier = "easeOutQuint";
      }
      {
        leaf = "layersIn";
        speed = 4;
        bezier = "easeOutQuint";
        style = "fade";
      }
      {
        leaf = "layersOut";
        speed = 1.5;
        bezier = "linear";
        style = "fade";
      }
      {
        leaf = "fadeLayersIn";
        speed = 1.79;
        bezier = "almostLinear";
      }
      {
        leaf = "fadeLayersOut";
        speed = 1.39;
        bezier = "almostLinear";
      }
      {
        leaf = "workspaces";
        speed = 3;
        bezier = "easeOutQuint";
      }
      {
        leaf = "specialWorkspace";
        speed = 3;
        bezier = "easeOutQuint";
        style = "slidevert";
      }
    ];
  };
}
