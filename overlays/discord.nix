{ ... }:

self: super: {
  discord = super.discord.override {
    withOpenASAR = false;
  };
}
