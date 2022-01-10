{ config, pkgs, ... }:

let
  radeon = "0000:29:00.0";
  radeon-audio = "0000:29:00.1";
  usb-controller = "0000:2a:00.3"; # Zeppelin USB 3.0 Host controller
  nvme-controller = "0000:01:00.0";
  ovmf = pkgs.OVMF.override { secureBoot = true; tpmSupport = true; };
in {
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

  systemd.services.windows = rec {
    path = with pkgs; [ qemu kmod ];
    serviceConfig = { Restart = "on-failure"; };
    environment = { SPICE_PORT = "5924"; };
    script = ''
      modprobe -i vfio_pci
      mkdir -p /tmp/defaultDrivers
      for dev in ${radeon} ${radeon-audio} ${usb-controller} ${nvme-controller}; do
        if [ -L /sys/bus/pci/drivers/vfio-pci/$dev ]; then
          echo $dev already bound to vfio-pci
          continue
        fi
        if [ -L /sys/bus/pci/devices/$dev/driver ]; then
          if ! [ -L /tmp/defaultDrivers/$dev ]; then
            ln -s $(readlink --canonicalize /sys/bus/pci/devices/$dev/driver) /tmp/defaultDrivers/$dev
          fi
          echo Unbinding $dev from $(readlink --canonicalize /sys/bus/pci/devices/$dev/driver)
          echo $dev > /sys/bus/pci/devices/$dev/driver/unbind
        fi
        echo Binding $dev to vfio-pci
        echo vfio-pci > /sys/bus/pci/devices/$dev/driver_override
        echo $dev > /sys/bus/pci/drivers/vfio-pci/bind
      done
      qemu-system-x86_64 \
        -name "win11" \
        -nodefaults \
        -enable-kvm \
        -machine q35,type=pc,accel=kvm,vmport=off,kernel_irqchip=on \
        -cpu host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time,kvm=off,hv_vendor_id=1234567890ab \
        -smp cores=6 \
        -m 16G \
        -mem-path /dev/hugepages \
        -net nic,model=virtio \
        -net bridge,br=virbr0 \
        -spice port=$SPICE_PORT,disable-ticketing=on \
        -chardev spiceport,id=spagent,name=org.spice-space.webdav.0,debug=0 \
        -chardev spicevmc,id=vdagent,name=vdagent,debug=0 \
        -device vfio-pci,host=29:00.0,x-vga=on,multifunction=on \
        -device vfio-pci,host=29:00.1 \
        -device vfio-pci,host=2a:00.3 \
        -device vfio-pci,host=01:00.0 \
        -device virtio-serial,id=virtio-serial0,max_ports=16 \
        -device virtserialport,chardev=spagent,name=org.spice-space.webdav.0 \
        -device virtserialport,chardev=vdagent,name=com.redhat.spice.0 \
        -chardev socket,id=chrtpm,path=/tmp/emulated_tpm/swtpm-sock \
        -tpmdev emulator,id=tpm0,chardev=chrtpm \
        -device tpm-tis,tpmdev=tpm0 \
        -boot order=cd \
        -bios ${ovmf.fd}/FV/OVMF.fd \
        -drive file=/tmp/Windows11.iso,format=raw,media=cdrom \
        -drive file=/tmp/virtio-win.iso,format=raw,media=cdrom \
        -nographic \
        -vga none
    '';
    postStop = ''
      for dev in ${radeon} ${radeon-audio} ${usb-controller} ${nvme-controller}; do
        if ! [ -L /tmp/defaultDrivers/$dev ]; then continue; fi
        if [ -L /sys/bus/pci/devices/$dev/driver ]; then
          echo Unbinding $dev from $(readlink --canonicalize /sys/bus/pci/devices/$dev/driver)
          echo $dev > /sys/bus/pci/devices/$dev/driver/unbind
        fi
        echo Binding $dev to $(readlink --canonicalize /tmp/defaultDrivers/$dev)
        echo $dev > /tmp/defaultDrivers/$dev/bind
      done
    '';
    after = [ "swtpm.target" ];
    bindsTo = [ "swtpm.service" ];
    wantedBy = [ "multi-user.target" ];
  };
}
