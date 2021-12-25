{ config, pkgs, ... }:

{
  services.samba = {
    enable = true;
    securityType = "user";
    extraConfig = ''
      workgroup = NEST
      server string = rocinante
      netbios name = rocinante
      security = user
      #use sendfile = yes
      #max protocol = smb2
      hosts allow = 10.0.0.0/8 192.168.0.0/16 localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
    '';
  };
  environment.systemPackages = [ config.services.samba.package ];
}
