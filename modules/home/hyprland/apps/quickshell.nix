# Quickshell layer-shell surfaces.
{h, ...}: {
  layerRules = [
    (h.layer {namespace = "quickshell-bar";} {
      no_anim = true;
    })
    (h.layer {namespace = "quickshell-launcher";} {
      no_anim = true;
    })
    (h.layer {namespace = "quickshell-bar-panel";} {
      no_anim = true;
    })
    (h.layer {namespace = "quickshell-osd";} {
      no_anim = true;
    })
  ];
}
