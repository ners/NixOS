{ ... }:

# Make Wine support both 32-bit and 64-bit executables
self: super: {
  wine = super.wine.override {
    wineBuild = "wineWow";
  };
}
