{ config, ... }:

let modifier = config.wayland.windowManager.sway.config.modifier;
in
{
  wayland.windowManager.sway.config.keybindings = {
    "${modifier}+Return" = "exec foot";
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "Monospace:size=11";
        dpi-aware = "auto";
        pad = "10x5 center";
      };
      mouse = { hide-when-typing = "yes"; };
      colors = {
        alpha = 0.85;
        background = "181818";
        foreground = "D8D8D8";
        regular0 = "181818"; # black
        regular1 = "AB4642"; # red
        regular2 = "A1B56C"; # green
        regular3 = "F7CA88"; # yellow
        regular4 = "7CAFC2"; # blue
        regular5 = "BA8BAF"; # magenta
        regular6 = "86C1B9"; # cyan
        regular7 = "D8D8D8"; # white
        bright0 = "585858"; # bright black
        bright1 = "AB4642"; # bright red
        bright2 = "A1B56C"; # bright green
        bright3 = "F7CA88"; # bright yellow
        bright4 = "7CAFC2"; # bright blue
        bright5 = "BA8BAF"; # bright magenta
        bright6 = "86C1B9"; # bright cyan
        bright7 = "F8F8F8"; # bright white
      };
    };
  };
}
