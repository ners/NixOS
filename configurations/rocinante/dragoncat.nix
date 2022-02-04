{ inputs, pkgs, ... }@args:

{
  imports = with inputs; [
    (import self.nixosProfiles.users.common (args // {
      username = "dragoncat";
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
    }))
  ];
}
