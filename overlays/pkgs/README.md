## Pkg overlays

This directory contains definitions for new packages in modules that contain derivations.

For example, the [nixos-wizard](./nixos-wizard/) package is defined here, and used in [the ISO image configuration](../../configurations/iso-image/default.nix#L19).

### Adding a new package

To add a new package, either create a Nix file in this directory, or a new directory with a `default.nix` file inside it.
The name of the Nix file (without the `.nix` extension), or the name of the directory, becomes the package name that is added to the `pkgs` attrset.
