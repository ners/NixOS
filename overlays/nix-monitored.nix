{ inputs, ... }:

self: super: {
  nix-monitored = self.callPackage inputs.nix-monitored { };

  nixos-rebuild = super.nixos-rebuild.override {
    nix = self.nix-monitored;
  };

  nix-direnv = super.nix-direnv.override {
    nix = self.nix-monitored;
  };
}
