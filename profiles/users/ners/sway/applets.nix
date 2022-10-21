{ pkgs, ... }:

let
  session = "sway-session.target";
in
{
  # For some reason, nm-applet doesn't show the right icon if it's not installed globally.
  home.packages = with pkgs; [
    networkmanagerapplet
  ];

  systemd.user.services.blueman-applet = {
    Service = {
      Restart = "always";
      ExecStart = "${pkgs.blueman}/bin/blueman-applet";
    };
    Install.WantedBy = [ session ];
    Unit = {
      PartOf = session;
      Requires = session;
      After = session;
    };
  };

  systemd.user.services.nm-applet = {
    Service = {
      Restart = "always";
      ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator";
    };
    Install.WantedBy = [ session ];
    Unit = {
      PartOf = session;
      Requires = session;
      After = session;
    };
  };
}
