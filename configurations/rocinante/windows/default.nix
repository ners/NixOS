{ pkgs, lib, ... }:

let
  radeon = "0000:29:00.0";
  radeon-audio = "0000:29:00.1";
  usb-controller = "0000:2a:00.3"; # Zeppelin USB 3.0 Host controller
  nvme-controller = "0000:01:00.0";
  world-interface = "wlp38s0";
  bridge-interface = "win-br";
in
{
  boot.kernelParams = [
    "amd_iommu=on"
    "pcie_aspm=off"
    "video=efifb:off"
    "default_hugepagesz=1GB"
    "hugepagesz=1GB"
    "hugepages=16"
  ];
  boot.kernelModules = [ "kvm-amd" "vfio" "vfio_pci" ];

  systemd.services.swtpm = {
    path = [ pkgs.swtpm ];
    script = ''
      mkdir -p /tmp/emulated_tpm
      swtpm socket \
        --tpmstate dir=/tmp/emulated_tpm \
        --ctrl type=unixio,path=/tmp/emulated_tpm/swtpm-sock \
        --log level=20 \
        --tpm2
    '';
    wantedBy = [ "windows.service" ];
  };

  # networking.bridges.${bridge-interface}.interfaces = [ world-interface ];
  # networking.interfaces.${bridge-interface}.useDHCP = true;
  # virtualisation.libvirtd.allowedBridges = [ bridge-interface ];

  systemd.services.windows = {
    path = with pkgs; [
      bridge-utils
      kmod
      qemu
      tunctl
    ];
    serviceConfig = { Restart = "on-failure"; };
    environment = {
      NAME = "win11";
      SPICE_PORT = "5924";
      BRIDGE_INTERFACE = bridge-interface;
      OVMF_FD = "${pkgs.OVMF.fd}/FV/OVMF.fd";
      DEVICES = "${radeon} ${radeon-audio} ${usb-controller} ${nvme-controller}";
    };
    preStart = builtins.readFile ./preStart.sh;
    script = builtins.readFile ./script.sh;
    postStop = builtins.readFile ./postStop.sh;
    after = [ "swtpm.target" ];
    bindsTo = [ "swtpm.service" ];
    wantedBy = lib.mkForce [ ];
  };
}
