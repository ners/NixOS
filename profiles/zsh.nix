{ pkgs, lib, ... }:

lib.mkMerge [
  {
    programs.zsh.enable = true;
  }
  (lib.optionalAttrs pkgs.stdenv.isLinux {
    environment.shells = [ pkgs.zsh ];
    users.defaultUserShell = pkgs.zsh;
  })
]
