## Overlays

This directory contains modules representing overlays that are applied over stable nixpkgs to build configurations.
This allows us to easily provide [new packages](./pkgs), or [replace existing ones](./OVMF.nix) in the standard repository.

Each overlay module accepts the flake inputs and system definition, and emits the [overlay lambda](https://nixos.wiki/wiki/Overlays) that extends nixpkgs stable.

The filenames of the modules are ignored, but for readability purposes it is a good idea to match them with the packages they expose.
