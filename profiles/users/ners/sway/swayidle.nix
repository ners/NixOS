{ pkgs, ... }:

let
  session = "sway-session.target";
in
{
  home.packages = with pkgs; [
    screenlock
    swayidle
    swaylock
  ];

  systemd.user.services.swayidle = {
    Service = {
      Restart = "always";
      ExecStart = ''
        ${pkgs.swayidle}/bin/swayidle -w \
          timeout 300 ${pkgs.screenlock}/bin/screenlock \
          timeout 1800 'systemctl suspend'
      '';
    };
    Install.WantedBy = [ session ];
    Unit = {
      PartOf = session;
      Requires = session;
      After = session;
    };
  };
}
