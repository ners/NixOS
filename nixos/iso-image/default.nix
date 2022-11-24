{ modulesPath
, inputs
, pkgs
, ...
}@args:

{
  imports = with inputs; [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-base.nix"
    Roles.desktop
    (import Profiles.users.common (args // {
      username = "nixos";
      initialHashedPassword = "";
      sshKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINBlAx5Hi5TsLsy5e+4OdBmM4oHtdUnqX5gtNbfc60rq ners"
      ];
    }))
  ];

  boot.initrd.luks.devices = { };
  environment.systemPackages = with pkgs; [
    nixos-wizard
  ];
}
