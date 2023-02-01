{ pkgs, lib, ... }:

(lib.mkIf pkgs.parsedSystem.isLinux {
  programs.firefox = {
    enable = true;
    package = pkgs.unstable.firefox-devedition-bin;
  };
})
