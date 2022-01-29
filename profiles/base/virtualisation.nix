{ config, pkgs, ... }:

let
  ovmf = pkgs.OVMF.override {
    secureBoot = true;
    tpmSupport = true;
  };
in
{
  virtualisation = {
    podman.enable = true;
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu = {
        ovmf = {
          enable = true;
          package = ovmf;
        };
        runAsRoot = false;
      };
    };
    spiceUSBRedirection.enable = true;
  };

  environment.systemPackages = with pkgs; [
    libguestfs
    spice-gtk
    spice-vdagent
    swtpm
  ];

  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
}
