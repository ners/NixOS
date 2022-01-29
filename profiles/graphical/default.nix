{ config, pkgs, ... }:

{
  imports = [ ./fonts.nix ];

  environment.systemPackages = with pkgs; [
    (callPackage ./winbox { })
    evince
    evolution
    fprintd
    gnome-connections
    gnome-usage
    gnome.eog
    gnome.file-roller
    gnome.geary
    gnome.gnome-tweak-tool
    gnome.nautilus
    gnomeExtensions.appindicator
    gparted
    libappindicator
    libimobiledevice
    mpv
    firefox-wayland
    neovim-qt
    virt-manager
    virt-viewer
  ];

  environment.variables = {
    VISUAL = "nvim-qt";
    MOZ_ENABLE_WAYLAND = "1";
  };

  xdg.portal = {
    enable = true;
    gtkUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };

  services = {
    xserver = {
      enable = true;
      xkbOptions = "caps:escape";
      libinput.enable = true;
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };
      desktopManager.gnome.enable = true;
    };
    blueman.enable = true;
    gnome = {
      core-os-services.enable = true;
      core-shell.enable = true;
      evolution-data-server.enable = true;
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
      sushi.enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      media-session.enable = true;
      pulse.enable = true;
    };
    dbus.enable = true;
    flatpak.enable = true;
    fprintd.enable = true;
    fwupd.enable = true;
    geoclue2.enable = true;
    localtime.enable = true;
    printing.enable = true;
    redshift.enable = true;
    usbmuxd.enable = true;
    gvfs.enable = true;
  };
  location.provider = "geoclue2";

  programs = {
    dconf.enable = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    nm-applet.enable = true;
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [ ];
    };
  };

  security = {
    rtkit.enable = true;
    pam.services = {
      login.fprintAuth = true;
      xscreensaver.fprintAuth = true;
      login.enableGnomeKeyring = true;
    };
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ amdvlk ];
    extraPackages32 = with pkgs; [ pkgsi686Linux.libva ];
    setLdLibraryPath = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = pkgs.lib.mkForce false;
}
