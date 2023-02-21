{ inputs, ... }:

self: super: rec {
  nix-monitored = inputs.nix-monitored.packages.${self.system}.default.override self;
  
  nix-direnv = super.nix-direnv.override {
    nix = nix-monitored;
  };
}
