{ pkgs, lib, ... }:

lib.mkMerge [
  {
    programs.zsh.enable = true;
  }
  (lib.optionalAttrs pkgs.parsedSystem.isLinux {
    environment.shells = [ pkgs.zsh ];
    users.defaultUserShell = pkgs.zsh;
  })
]
