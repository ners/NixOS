{ pkgs, ... }:

{
  systemd.user.services.mako = {
    Install = {
      WantedBy = [ "sway-session.target" ];
    };
    Service = {
      Restart = "on-failure";
      ExecStart = "${pkgs.mako}/bin/mako";
    };
  };

  programs.mako = {
    enable = true;
    defaultTimeout = 3000;
    font = "Monospace 11";
  };
}
