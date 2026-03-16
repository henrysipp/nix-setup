{pkgs, ...}: {
  virtualisation.containers.enable = true;
  virtualisation = {
    docker.enable = true;
  };

  environment.systemPackages = with pkgs; [
    ddev
    unstable.devenv
  ];
}
