{
  config,
  pkgs,
  ...
}: {
  containers.sonarr = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "10.50.0.1";
    localAddress = "10.50.0.5";

    bindMounts = {
      "/var/lib" = {
        hostPath = "/persistent/sonarr";
        isReadOnly = false;
      };
      "/media" = {
        hostPath = "/mnt/net-video";
        isReadOnly = false;
      };
    };

    config = {
      config,
      pkgs,
      ...
    }: {
      services.sonarr = {
        enable = true;
        openFirewall = true;
      };
      system.stateVersion = "25.05";
    };
  };
}
