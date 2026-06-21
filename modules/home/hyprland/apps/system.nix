# Shared window behavior for tagged windows.
# Base: omarchy/default/hypr/apps/system.lua
{h, ...}: {
  windowRules = [
    (h.window {tag = "floating-window";} {
      float = true;
      center = true;
      size = [875 600];
    })
  ];
}
