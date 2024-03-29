## System configurations

This directory contains definitions for NixOS systems that can be built from this repository.

Each system is described with a directory that contains, at minimum:
 - a `default.nix` file that contains the configuration for the system, and
 - a system definition file that contains the name of the [platform](https://github.com/NixOS/nixpkgs/blob/master/lib/systems/supported.nix) this system is expected to run on.

The name of the directory is treated as the name of the configuration, as well as its default hostname.

### Adding a new configuration

The most common use-case for creating a new configuration is when installing NixOS to a new computer from the live environment.
This repository offers an [installation wizard](../overlays/pkgs/nixos-wizard/) which simplifies installation, as well as adding new configurations.
Simply run `wizard` and follow the steps.

To manually add a new configuration, create a new directory in this one, named after the configuration you wish to add.
Create the system definition file, containing the name of the system the configuration targets; e.g. "x86_64-linux".

Also add a `default.nix` file that describes the configuration.

If the configuration describes a computer, then also add the `hardware-configuration.nix`, as generated by `nixos-generate-config`.

Finally, the new configuration can be built from the root of the flake:
```sh
# Change this
configuration=normandy

# Build or switch
nixos-rebuild build --flake .#${configuration} --impure
nixos-rebuild switch --flake .#${configuration} --impure

# Install from live media
nixos-install --flake .#${configuration} --impure
```
