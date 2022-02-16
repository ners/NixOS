{ inputs, pkgs, ... }:

{
  imports = with inputs; [
    self.nixosProfiles.boot
    self.nixosProfiles.btrfs
    self.nixosProfiles.fonts
    self.nixosProfiles.fprintd
    self.nixosProfiles.geoclue
    self.nixosProfiles.gnome
    self.nixosProfiles.pipewire
    self.nixosProfiles.virtualisation
    self.nixosRoles.base
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
