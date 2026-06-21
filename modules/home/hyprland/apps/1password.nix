# App-specific window rules.
# Base: omarchy/default/hypr/apps/1password.lua
{h, ...}: {
  windowRules = [
    (h.window "^(1[p|P]assword)$" {
      no_screen_share = true;
      tag = "+floating-window";
    })
  ];
}
