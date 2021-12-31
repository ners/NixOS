{ config, pkgs, ... }:

let unstable = import <nixos-unstable> { config.allowUnfree = true; };
in {
  environment.systemPackages = with pkgs; [
    evince
    evolution
    fprintd
    gnome-usage
    gnome.eog
    gnome.geary
    gnome3.file-roller
    gnome3.gnome-tweak-tool
    gnome3.networkmanagerapplet
    gnomeExtensions.appindicator
    gparted
    libappindicator
    libimobiledevice
    unstable.neovim-qt
    unstable.firefox-devedition-bin
    virt-manager
    virt-viewer
  ];

  environment.variables = {
    VISUAL = "nvim-qt";
    MOZ_ENABLE_WAYLAND = "1";
  };

  fonts = {
    fontconfig.enable = true;
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "Cousine" "FiraCode" "RobotoMono" "SourceCodePro" ]; })
      carlito
      charis-sil
      crimson
      dejavu_fonts
      fira
      fira-code
      fira-mono
      inconsolata
      inter
      inter-ui
      libertine
      noto-fonts
      noto-fonts-emoji
      noto-fonts-extra
      roboto
      roboto-mono
      source-code-pro
      source-sans-pro
      source-serif-pro
      twitter-color-emoji
      unstable.corefonts
    ];
    fontconfig.defaultFonts = {
      sansSerif = [ "Source Sans Pro" ];
      serif = [ "Source Serif Pro" ];
      monospace = [ "Cousine Nerd Font" ];
      emoji = [ "Twitter Color Emoji" ];
    };
    fontconfig.localConf = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <alias binding="weak">
          <family>monospace</family>
          <prefer>
            <family>emoji</family>
          </prefer>
        </alias>
        <alias binding="weak">
          <family>sans-serif</family>
          <prefer>
            <family>emoji</family>
          </prefer>
        </alias>
        <alias binding="weak">
          <family>serif</family>
          <prefer>
            <family>emoji</family>
          </prefer>
        </alias>
      </fontconfig>
          '';
  };

  xdg.portal = {
    enable = true;
    gtkUsePortal = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
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
      evolution-data-server.enable = true;
      core-shell.enable = true;
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
