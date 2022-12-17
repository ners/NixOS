{ ... }:

self: super: {
  nixos-rebuild = super.nixos-rebuild.override {
    nix = self.nix-monitored;
  };
  nix-direnv = super.nix-direnv.override {
    nix = self.nix-monitored;
  };
}
