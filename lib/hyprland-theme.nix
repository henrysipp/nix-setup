# Hyprland decoration colors from a Stylix base16 palette.
{colors}: let
  tag = colors.withHashtag;
  hex = colors;
in {
  gapInner = 4;
  gapOuter = 8;
  rounding = 8;
  activeBorderColor = tag.base0D;
  inactiveBorderColor = "rgba(${hex.base03}99)";
  shadowColor = "rgba(${hex.base00}ee)";
}
