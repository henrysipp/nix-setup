{pkgs, ...}: {
  flake.modules = {
    nixosUsers.root = {pkgs, ...}: {
      users.users.root = {
        initialPassword = "id";
      };
    };
  };
}
