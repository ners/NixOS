{ inputs, pkgs, ... }:

{
  imports = with inputs; [
    ./hardware-configuration.nix
    self.profiles.users.dragoncat
    self.roles.server
  ];

  systemd.network.wait-online.extraArgs = [
    "--interface=enp0s3"
  ];
}
