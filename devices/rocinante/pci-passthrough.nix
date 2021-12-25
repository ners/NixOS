{ config, pkgs, lib, ... }:

with lib;
let cfg = config.pciPassthrough;
in {
  ###### interface
  options.pciPassthrough = {
    enable = mkEnableOption "PCI Passthrough";

    cpuType = mkOption {
      description = "One of `intel` or `amd`";
      default = "intel";
      type = types.str;
    };

    devices = mkOption {
      description =
        "PCI IDs of devices to bind to vfio-pci, found in /sys/bus/pci/devices";
      default = [ ];
      example = [ "0000:29:00.0" "0000:29:00.1" ];
      type = types.listOf
        (types.strMatching "[0-9a-f]{4}:[0-9a-f]{2}:[0-9a-f]{2}.[0-9a-f]");
      # example = [ "1002:67df" "1002:aaf0" ];
      # type = types.listOf (types.strMatching "[0-9a-f]{4}:[0-9a-f]{4}");
    };

    disableEFIfb = mkOption {
      type = types.bool;
      default = false;
      example = true;
      description = "Disables the usage of the EFI framebuffer on boot.";
    };

    libvirtUsers = mkOption {
      description = "Extra users to add to libvirtd (root is already included)";
      type = types.listOf types.str;
      default = [ ];
    };
  };

  ###### implementation
  config = (mkIf cfg.enable {

    boot.blacklistedKernelModules = [ "nouveau" "nvidia" "amdgpu" "radeon" ];
    boot.kernelParams = [ "${cfg.cpuType}_iommu=on" "pcie_aspm=off" ]
      ++ (optional cfg.disableEFIfb "video=efifb:off");
    boot.kernelModules = [ "kvm-${cfg.cpuType}" "vfio" "vfio_pci" ];

    # boot.extraModprobeConfig = "options vfio-pci ids=${builtins.concatStringsSep "," cfg.devices}";

    boot.initrd.availableKernelModules = [ "vfio_pci" ];
    boot.initrd.preDeviceCommands = ''
      DEVS='${builtins.concatStringsSep " " cfg.devices}'
      for DEV in $DEVS; do
      	echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
      done
      modprobe -i vfio-pci
    '';
  });
}
