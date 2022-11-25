{ inputs, pkgs, ... }:

{
  imports = with inputs; [
    self.roles.base
    self.profiles.users.dragoncat
  ];
}
