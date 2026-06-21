# Quickshell layer-shell surfaces.
{h, ...}: {
  layerRules = [
    (h.layer {match = {namespace = "quickshell-bar";};} {
      no_anim = true;
    })
    (h.layer {match = {namespace = "quickshell-launcher";};} {
      no_anim = true;
    })
    (h.layer {match = {namespace = "quickshell-bar-panel";};} {
      no_anim = true;
    })
    (h.layer {match = {namespace = "quickshell-osd";};} {
      no_anim = true;
    })
  ];
}
