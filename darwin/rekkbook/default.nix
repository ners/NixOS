{ inputs, pkgs, ... }:

{
  imports = with inputs; [
    self.roles.darwin
    self.profiles.users.rekk
    ./homebrew.nix
  ];
}
