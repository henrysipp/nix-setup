{self, username, pkgs, ...}:

{

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # My own edits as follows:

  # Unlock sudo with our fingerprint.
  security.pam.services.sudo_local.touchIdAuth = true;
  
  # Darwin specific pieces
  system.primaryUser = username;
  system.defaults = {
    dock.autohide = true; # Auto hide the dock
    dock.mru-spaces = false; # Most recent used spaces ordering
    finder.FXPreferredViewStyle = "clmv"; # Default finder view is columns view
  };


}