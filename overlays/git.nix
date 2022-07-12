{ ... }:

# Make Git support libsecret
self: super: {
  gitAndTools = super.gitAndTools // {
    gitFull = super.gitAndTools.gitFull.override {
      withLibsecret = true;
    };
  };
}
