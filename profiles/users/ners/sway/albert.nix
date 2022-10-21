{ config, pkgs, lib, ... }:

let
  modifier = config.wayland.windowManager.sway.config.modifier;
  session = "sway-session.target";
in
{
  systemd.user.services.albert = {
    Service = {
      Restart = "on-failure";
      ExecStart = "${pkgs.albert}/bin/albert";
    };
    Install.WantedBy = [ session ];
    Unit = {
      PartOf = session;
      Requires = session;
      After = session;
    };
  };

  home.packages = with pkgs; [
    albert
    (imagemagick.overrideAttrs (_: { buildInputs = [ pango ]; }))
  ];

  wayland.windowManager.sway.config = {
    keybindings = {
      "${modifier}+space" = "exec albert show";
    };
  };

  xdg.configFile."albert/albert.conf".text = lib.generators.toINI { } {
    General = {
      showTray = true;
      terminal = "foot";
    };
    "org.albert.extension.applications" = {
      enabled = true;
      fuzzy = false;
      use_generic_name = true;
      use_keywords = true;
    };
    "org.albert.extension.python" = {
      enabled = true;
      enabled_modules =
        "datetime, google_translate, pomodoro, vpn, wikipedia, youtube, unicode_emoji";
    };
    "org.albert.frontend.widgetboxmodel" = {
      alwaysOnTop = true;
      clearOnHide = false;
      displayIcons = true;
      displayScrollbar = false;
      displayShadow = true;
      hideOnClose = false;
      hideOnFocusLoss = true;
      itemCount = 5;
      showCentered = true;
      theme = "Numix Rounded";
    };
    "org.albert.extension.calculator".enabled = true;
    "org.albert.extension.ssh".enabled = true;
  };

}
