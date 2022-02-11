{ ... }:

# OVMF is a port of Intel's tianocore firmware to the qemu virtual machine, allowing us to virtualise UEFI VMs.
# This overlay ensures that it is built with secure boot and TPM support enabled, to support virtualising Windows 11
self: super: {
  OVMF = super.OVMF.override {
    secureBoot = true;
    tpmSupport = true;
  };
}
