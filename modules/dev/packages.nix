{...}: {
  flake.modules.nixos.dev = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      # Version control
      gh

      # Code formatting
      alejandra

      # Build tools
      gnumake

      # Text processing
      ripgrep

      # System utilities
      curl
      wget

      # Editors
      neovim
      vscode
      jetbrains-toolbox
    ];
  };
}
