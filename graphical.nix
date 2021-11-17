{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    evince
    evolution
    fprintd
    gnome.eog
    gnome.geary
    gnome3.gnome-tweak-tool
    gnome3.networkmanagerapplet
    gnomeExtensions.appindicator
    libappindicator
    libimobiledevice
    neovim-qt
    unstable.firefox-devedition-bin
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
      (nerdfonts.override { fonts = [ "Cousine" "FiraCode" "RobotoMono" ]; })
      carlito
      corefonts
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
    ];
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
    fontconfig.defaultFonts = {
      sansSerif = [ "Arimo" ];
      serif = [ "Tinos" ];
      monospace = [ "Cousine" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-wlr ];
  };

  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
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
    };
    pipewire = {
      alsa.enable = true;
      alsa.support32Bit = true;
      enable = true;
      jack.enable = true;
      media-session.enable = true;
      pulse.enable = true;
    };
    flatpak.enable = true;
    fprintd.enable = true;
    redshift.enable = true;
    usbmuxd.enable = true;
    dbus.enable = true;
  };

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

  sound.enable = true;
}
