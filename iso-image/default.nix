{ modulesPath, pkgs, ... }:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-base.nix"
    "${modulesPath}/installer/cd-dvd/channel.nix"

    ../profiles/base
    ../profiles/graphical
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  users.users.nixos.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMOpF57zQbYYnhtJfE83BNLj4nFwkv9Og3jqPJVvTlvL ners"
  ];
}
