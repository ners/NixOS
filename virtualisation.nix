{ config, pkgs, ... }:

{
  virtualisation = {
    podman.enable = true;
    libvirtd = {
      enable = true;
      qemuOvmf = true;
      qemuRunAsRoot = false;
    };
  };

  environment.systemPackages = with pkgs; [
    OVMF
    libguestfs
    spice-gtk
    spice-vdagent
    swtpm
    virt-manager
    virt-viewer
  ];

  security.wrappers.spice-client-glib-usb-acl-helper.source =
    "${pkgs.spice-gtk}/bin/spice-client-glib-usb-acl-helper";

  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
}
