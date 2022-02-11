{ pkgs, lib, ... }:

{
  dconf.settings = lib.dconfFlatten {
    com.github.johnfactotum.Foliate.view = {
      autohide-cursor = false;
      font = "Serif 16";
    };
  };
}
