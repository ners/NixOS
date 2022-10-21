{ pkgs, ... }:

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

  programs.mako = {
    enable = true;
    defaultTimeout = 3000;
    font = "Monospace 11";
  };
}
