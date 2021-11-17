{ config, pkgs, ... }:

{
  boot = {
    kernelParams = [ "security=selinux" ];
    kernelPatches = [{
      name = "selinux-config";
      patch = null;
      extraConfig = ''
        SECURITY_SELINUX y
        SECURITY_SELINUX_BOOTPARAM n
        SECURITY_SELINUX_DISABLE n
        SECURITY_SELINUX_DEVELOP y
        SECURITY_SELINUX_AVC_STATS y
        SECURITY_SELINUX_CHECKREQPROT_VALUE 0
      '';
    }];
  };

  environment.systemPackages = with pkgs; [ libselinux policycoreutils ];

  systemd.package = pkgs.systemd.override { withSelinux = true; };
}
