{ ... }:

{
  imports = [ <home-manager/nixos> ];
  users.users.ners = {
    isNormalUser = true;
    isSystemUser = false;
    createHome = true;
    initialHashedPassword =
      "$6$P8pZJbrdjFXP7Bkf$CSxDmrTTO6o5pWUVXW0hy/c.Zdf7WtzNOPk1KiEDrDtyDf8x6V.ZvSzhh8kJWx0DKpObq4077SH1BRZZ0wgU/0";
    extraGroups =
      [ "ners" "audio" "libvirtd" "networkmanager" "video" "wheel" "dialout" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMOpF57zQbYYnhtJfE83BNLj4nFwkv9Og3jqPJVvTlvL ners"
    ];
  };
  users.groups.ners.gid = 1000;
  home-manager.users.ners = import ./home/ners/home.nix;
}
