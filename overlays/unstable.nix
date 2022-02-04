{ inputs, system, ... }:

self: super: {
  unstable = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
}
