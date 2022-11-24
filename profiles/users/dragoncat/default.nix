{ inputs, pkgs, ... }@args:

{
  imports = with inputs; [
    (import self.profiles.users.common (args // {
      username = "dragoncat";
      initialHashedPassword = "$6$P8pZJbrdjFXP7Bkf$CSxDmrTTO6o5pWUVXW0hy/c.Zdf7WtzNOPk1KiEDrDtyDf8x6V.ZvSzhh8kJWx0DKpObq4077SH1BRZZ0wgU/0";
      extraGroups = [
        "audio"
        "dialout"
        "gold"
        "libvirtd"
        "networkmanager"
        "plex"
        "qemu-libvirtd"
        "transmission"
        "users"
        "video"
        "wheel"
      ];
      sshKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINBlAx5Hi5TsLsy5e+4OdBmM4oHtdUnqX5gtNbfc60rq ners"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMxceZEJ4aQXkvHWWDh5TXNk9XdpIZFQKGhQGAZIeLxr rekk"
      ];
    }))
  ];
}
