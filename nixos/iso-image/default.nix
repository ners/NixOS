{ modulesPath
, inputs
, pkgs
, ...
}@args:

{
  imports = with inputs; [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-base.nix"
    self.roles.desktop
    (import self.profiles.users.common (args // {
      username = "nixos";
      initialHashedPassword = "";
      sshKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINBlAx5Hi5TsLsy5e+4OdBmM4oHtdUnqX5gtNbfc60rq ners"
      ];
    }))
  ];

  boot.initrd = {
    luks.devices = { };
    systemd.enable = false;
  };

  environment.systemPackages = with pkgs; [
    nixos-wizard
  ];

  isoImage.edition = "gnome";
  services.xserver.displayManager = {
    gdm.autoSuspend = false;
    autoLogin = {
      enable = true;
      user = "nixos";
    };
  };
}
