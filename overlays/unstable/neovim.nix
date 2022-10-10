{ lib, unstable, ... }:

self: super: {
  inherit (unstable) neovim neovim-qt neovim-qt-unwrapped;
  neovim-unwrapped = lib.recursiveUpdate unstable.neovim-unwrapped {
    lua.pkgs.lib = unstable.neovim-unwrapped.lua.pkgs.luaLib;
  };
}
