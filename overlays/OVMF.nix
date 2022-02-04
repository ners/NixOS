{ ... }:

self: super: {
  OVMF = super.OVMF.override {
    secureBoot = true;
    tpmSupport = true;
  };
}
