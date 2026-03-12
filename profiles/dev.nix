{pkgs, ...}: {
  virtualisation.containers.enable = true;
  virtualisation = {
    docker.enable = true;
  };
}
