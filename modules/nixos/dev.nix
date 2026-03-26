{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hokum.dev.enable = lib.mkEnableOption "development tooling and container runtime";

  config = lib.mkIf config.hokum.dev.enable {
    virtualisation.containers.enable = true;
    virtualisation.docker.enable = true;

    environment.systemPackages = with pkgs; [
      ddev
      unstable.devenv
    ];
  };
}
