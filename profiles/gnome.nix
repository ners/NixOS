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

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gedit # text editor
    epiphany # web browser
    geary # email reader
    gnome-characters
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    yelp # Help view
    gnome-contacts
    gnome-initial-setup
  ]);

  environment.systemPackages = with pkgs; with gnome; with gnomeExtensions; [
    adwaita-icon-theme
    appindicator
    eog
    evince
    evolution
    file-roller
    geary
    gnome-connections
    gnome-tweaks
    gnome-usage
    nautilus
    nufraw-thumbnailer
  ];
}
