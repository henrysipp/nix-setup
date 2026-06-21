{...}: {
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        cursor-theme = "Adwaita";
        cursor-size = 24;
        monospace-font-name = "Berkeley Mono 11";
      };

      "org/gnome/Console" = {
        use-system-font = true;
        custom-font = "";
      };
    };
  };
}
