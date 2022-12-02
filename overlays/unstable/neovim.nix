{ lib, unstable, ... }:

self: super: {
  inherit (unstable)
    neovim
    neovim-unwrapped
    neovimUtils
    wrapNeovimUnstable
    ;
}
