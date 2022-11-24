{ lib, unstable, ... }:

self: super: {
  inherit (unstable)
    neovim
    neovim-unwrapped
    neovim-qt
    neovim-qt-unwrapped
    neovimUtils
    wrapNeovimUnstable
    ;
}
