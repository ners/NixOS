{ inputs, ... }:

self: super: {
  nix-monitored = inputs.nix-monitored.packages.${self.system}.default.override self;

  nixos-rebuild = super.nixos-rebuild.override {
    nix = self.nix-monitored;
  };

  darwin-rebuild = super.darwin-rebuild.override {
    nix = self.nix-monitored;
  };

  nixos-update = super.nixos-update.override {
    nix = self.nix-monitored;
  };

  darwin-update = super.darwin-update.override {
    nix = self.nix-monitored;
  };

  nix-direnv = super.nix-direnv.override {
    nix = self.nix-monitored;
  };
}
