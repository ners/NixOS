{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    slurp
  ];

  xdg.configFile."xdg-desktop-portal-wlr/config".text =
    lib.generators.toINI { } {
      screencast = {
        output_name = "";
        max_fps = "30";
        chooser_cmd = "slurp -f %o -or";
        chooser_type = "simple";
      };
    };
}
