{ pkgs, ... }:

{
  services = {
    xserver = {
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };
      desktopManager.gnome.enable = true;
    };
    gnome = {
      core-os-services.enable = true;
      core-shell.enable = true;
      evolution-data-server.enable = true;
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
      sushi.enable = true;
    };
    dbus.enable = true;
    gvfs.enable = true;
  };

  programs = {
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  security.pam.services.login.enableGnomeKeyring = true;

  environment.systemPackages = with pkgs; [
    evince
    evolution
    gnome-connections
    gnome-usage
    gnome.eog
    gnome.file-roller
    gnome.geary
    gnome.gnome-tweaks
    gnome.nautilus
    gnomeExtensions.appindicator
    nufraw-thumbnailer
  ];
}
