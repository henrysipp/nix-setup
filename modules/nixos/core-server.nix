{lib, pkgs, ...}: {
  boot.loader.systemd-boot.configurationLimit = lib.mkDefault 5;
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    curl
    git
    alacritty
    flameshot
    git
    neofetch
    gh
    gnumake
  ];

  environment.variables.EDITOR = "nvim";
}
