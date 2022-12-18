{ inputs, pkgs, ... }:

let lan = "eno2"; in
{
  imports = with inputs; [
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.common-cpu-intel
    nixos-hardware.nixosModules.common-gpu-amd
    nixos-hardware.nixosModules.common-pc
    nixos-hardware.nixosModules.common-pc-ssd
    self.roles.desktop
    self.profiles.users.ners
  ];

  systemd.network = {
    wait-online.extraArgs = [
      "--interface=${lan}"
    ];
    links."40-wake-on-lan" = {
      matchConfig.OriginalName = lan;
      linkConfig = {
        NamePolicy = "keep kernel database onboard slot path";
        AlternativeNamesPolicy = "database onboard slot path";
        MACAddressPolicy = "persistent";
        WakeOnLan = "magic";
      };
    };
  };

  networking.interfaces.${lan}.wakeOnLan.enable = true;

  hardware.keyboard.zsa.enable = true;

  environment.systemPackages = with pkgs; [
    wally-cli
  ];
}
