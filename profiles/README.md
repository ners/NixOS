## Profiles

Profiles are modules that enable and configure an individual unit of functionality with sensible defaults.

A profile should be small and unassuming enough to be shared between multiple configurations; for example, the [Gnome profile](./gnome.nix) is used by all [graphical configurations](../roles/desktop.nix), such as the [ISO image](../configurations/iso-image) or [Normandy](../configurations/normandy).

At the same time, a profile should be self-contained such that no extra work should be duplicated by any configuration that uses it; for example, the [Pipewire profile](./pipewire.nix) also [disables Pulseaudio](./pipewire.nix#L13).
