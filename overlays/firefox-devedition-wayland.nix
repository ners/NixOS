{ ... }:

self: super: {
  firefox-devedition-wayland = super.wrapFirefox super.firefox-devedition-bin-unwrapped {
    forceWayland = true;
  };
}
