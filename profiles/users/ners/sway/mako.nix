{ config, pkgs, ... }:

let
  session = "sway-session.target";
in
{
  systemd.user.services.mako = {
    Service = {
      Restart = "always";
      ExecStart = "${pkgs.mako}/bin/mako";
    };
    Install.WantedBy = [ session ];
    Unit = {
      PartOf = session;
      Requires = session;
      After = session;
    };
  };

  programs.mako = with config.colorScheme.colors; {
    enable = true;
    defaultTimeout = 3000;
    font = "Inter Nerd Font 11";

    backgroundColor = "#${base00}";
    textColor = "#${base05}";
    borderColor = "#${base0D}";

    extraConfig = ''
      [urgency=low]
      background-color=#${base00}
      text-color=#${base0A}
      border-color=#${base0D}

      [urgency=high]
      background-color=#${base00}
      text-color=#${base08}
      border-color=#${base0D}
    '';
  };
}
