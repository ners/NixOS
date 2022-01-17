{ modulesPath, pkgs, lib, ... }:

with lib;

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-base.nix"
    "${modulesPath}/installer/cd-dvd/channel.nix"

    ../profiles/base
    ../profiles/graphical
  ];

  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.luks.devices = mkForce { };
  };

  users.users.nixos = {
    initialHashedPassword = mkForce "$6$zX.Yogo86CRvoRh1$Totj9JN3E6yCW38QEOPk43bZ8.axtM64jKpe3jfNrMISQohkqoCjwDAcCLVoVoYMSyvSsgSrcyqSKLRuV9y310";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMOpF57zQbYYnhtJfE83BNLj4nFwkv9Og3jqPJVvTlvL ners"
    ];
  };
}
