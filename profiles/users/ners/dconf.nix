{ pkgs, ... }:

{
  dconf.settings = pkgs.lib.dconfFlatten {
    com.github.johnfactotum.Foliate.view = {
      autohide-cursor = false;
      font = "Serif 16";
    };
  };
}
