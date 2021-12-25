{ config, pkgs, ... }:

let
  radeon = "0000:29:00.0";
  radeon-audio = "0000:29:00.1";
  usb-controller = "0000:2a:00.3"; # Zeppelin USB 3.0 Host controller
  nvme-controller = "0000:01:00.0";
  ovmf = pkgs.OVMF.override { secureBoot = true; tpmSupport = true; };
in {
  imports = [ ./pci-passthrough.nix ];

  pciPassthrough = {
    enable = true;
    cpuType = "amd";
    devices = [ radeon radeon-audio usb-controller nvme-controller ];
    libvirtUsers = [ "dragoncat" ];
    disableEFIfb = true;
  };

  boot.kernelParams =
    [ "default_hugepagesz=1GB" "hugepagesz=1GB" "hugepages=16" ];

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

  systemd.services.windows = {
    path = [ pkgs.qemu ];
    serviceConfig = { Restart = "on-failure"; };
    environment = { SPICE_PORT = "5924"; };
    script = ''
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
      	-drive file=/tmp/virtio-win-0.1.208.iso,format=raw,media=cdrom \
      	-nographic \
      	-vga none
    '';
    after = [ "swtpm.target" ];
    bindsTo = [ "swtpm.service" ];
    wantedBy = [ "multi-user.target" ];
  };
}
