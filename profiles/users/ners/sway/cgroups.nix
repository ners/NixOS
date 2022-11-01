{ pkgs, ... }:

let
  session = "sway-session.target";
in
{
  systemd.user.services.assign-cgroups = {
    Service = {
      Restart = "always";
      ExecStart = "${pkgs.unstable.assign-cgroups}/bin/assign-cgroups";
    };
    Install.WantedBy = [ session ];
    Unit = {
      PartOf = session;
      Requires = session;
      After = session;
    };
  };
}
