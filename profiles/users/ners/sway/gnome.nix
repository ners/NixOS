{ pkgs, ... }:

let
  session = "sway-session.target";
in
{
  wayland.windowManager.sway.config.startup = [
    {
      command =
        "export $(${pkgs.gnome.gnome-keyring}/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)";
      always = true;
    }
  ];

  systemd.user.services.polkit = {
    Service = {
      Restart = "always";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    };
    Install.WantedBy = [ session ];
    Unit = {
      PartOf = session;
      Requires = session;
      After = session;
    };
  };
}
