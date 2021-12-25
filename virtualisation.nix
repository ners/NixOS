{ config, pkgs, ... }:

let
  ovmf = pkgs.OVMF.override {
    secureBoot = true;
    tpmSupport = true;
  };
in {
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
        verbatimConfig = ''
          nvram = ["${ovmf.fd}/FV/OVMF.fd:${ovmf.fd}/FV/OVMF_VARS.fd"]
        '';
      };
    };
  };

  environment.systemPackages = with pkgs; [
    libguestfs
    spice-gtk
    spice-vdagent
    swtpm
  ];

  # security.wrappers.spice-client-glib-usb-acl-helper.source =
  #   "${pkgs.spice-gtk}/bin/spice-client-glib-usb-acl-helper";

  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
}
