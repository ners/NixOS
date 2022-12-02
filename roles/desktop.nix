{ inputs, pkgs, options, ... }:

{
  imports = with inputs.self; [
    profiles.fonts
    profiles.fprintd
    profiles.geoclue
    profiles.gnome
    profiles.pipewire
    profiles.plymouth
    profiles.virtualisation
    roles.nixos
  ];

  environment.systemPackages = with pkgs; [
    firefox-wayland
    gparted
    libappindicator
    libimobiledevice
    mpv
    neovide
    speedtest-cli
    spice-gtk
    thunderbird
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

  xdg.portal = {
    enable = true;
    wlr.enable = true;
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

  console = {
    # Enable setting virtual console options as early as possible (in initrd).
    earlySetup = true;
    # Provide a hi-dpi console font.
    packages = options.console.packages.default ++ [ pkgs.terminus_font ];
  };
}
