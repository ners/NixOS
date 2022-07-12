{ config, pkgs, lib, ... }:

let modifier = config.wayland.windowManager.sway.config.modifier;
in
{
  programs.rofi = {
    enable = true;
    package = with pkgs.unstable; rofi-wayland.override {
      plugins = [ rofi-calc rofi-emoji ];
    };
    extraConfig = {
      modi = "drun,calc,emoji";
    };
    theme =
      with config.lib.formats.rasi;
      with config.colorScheme.colors;
      {
        "*" = {
          border = mkLiteral "0";
          margin = mkLiteral "0";
          padding = mkLiteral "0";
          spacing = mkLiteral "0";

          bg = mkLiteral "#151515";
          bg-alt = mkLiteral "#232323";
          fg = mkLiteral "#FFFFFF";
          fg-alt = mkLiteral "#424242";

          background-color = mkLiteral "@bg";
          text-color = mkLiteral "@fg";
        };

        window = {
          transparency = "real";
        };

        mainbox = {
          children = mkLiteral "[inputbar, listview]";
        };

        inputbar = {
          background-color = mkLiteral "@bg-alt";
          children = mkLiteral "[prompt, entry]";
        };

        entry = {
          background-color = mkLiteral "inherit";
          padding = mkLiteral "12px 3px";
        };

        prompt = {
          background-color = mkLiteral "inherit";
          padding = mkLiteral "12px";
        };

        listview = {
          lines = mkLiteral "8";
        };

        element = {
          children = mkLiteral "[element-icon, element-text]";
        };

        element-icon = {
          padding = mkLiteral "10px 10px";
        };

        element-text = {
          padding = mkLiteral "10px 0";
          text-color = mkLiteral "@fg-alt";
        };

        "element-text selected" = {
          text-color = mkLiteral "@fg";
        };
      };
  };

  wayland.windowManager.sway.config = {
    keybindings = {
      "${modifier}+space" = "exec rofi -show drun";
    };
  };
}
