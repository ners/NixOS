{ inputs, pkgs, ... }:

{
  imports = with inputs.self; [
    nixosProfiles.boot
    nixosProfiles.btrfs
    nixosProfiles.fonts
    nixosProfiles.fprintd
    nixosProfiles.geoclue
    nixosProfiles.gnome
    nixosProfiles.pipewire
    nixosProfiles.virtualisation
    nixosRoles.base
  ];

  environment.systemPackages = with pkgs; [
    firefox-wayland
    gparted
    libappindicator
    libimobiledevice
    mpv
    neovim-qt
    speedtest-cli
    spice-gtk
    transmission-gtk
    virt-manager
    virt-viewer
  ];

  services = {
    xserver = {
      enable = true;
      xkbOptions = "caps:escape";
      libinput.enable = true;
    };
    blueman.enable = true;
    flatpak.enable = true;
    fwupd.enable = true;
    localtime.enable = true;
    printing.enable = true;
    redshift.enable = true;
    usbmuxd.enable = true;
  };

  programs = {
    mtr.enable = true;
    nm-applet.enable = true;
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      #extraPackages = [ ];
    };
  };

  security.rtkit.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = [ pkgs.amdvlk ];
    extraPackages32 = [ pkgs.pkgsi686Linux.libva ];
    setLdLibraryPath = true;
  };

}
