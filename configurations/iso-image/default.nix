{ modulesPath
, inputs
, pkgs
, ...
}@args:

{
  imports = with inputs; [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-base.nix"
    self.nixosRoles.guest
    self.nixosRoles.desktop
    (import self.nixosProfiles.users.common (args // { username = "nixos"; initialHashedPassword = ""; }))
  ];

  boot.initrd.luks.devices = { };
  boot.extraModulePackages = [ ];

  environment.systemPackages = with pkgs; [
    nixos-wizard
  ];
}
