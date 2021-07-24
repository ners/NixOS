{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    chromium
    firefox
    fprintd
    gnome3.adwaita-icon-theme
    gnome3.gnome-tweak-tool
    gnome3.networkmanagerapplet
    gnomeExtensions.appindicator
    libappindicator
    neovim-qt
    yaru-theme
  ];

  environment.variables = { VISUAL = "nvim-qt"; };

  fonts = {
    fontconfig.enable = true;
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "RobotoMono" ]; })
      carlito
      corefonts
      dejavu_fonts
      inconsolata
      inter
      inter-ui
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
      videoDrivers = [ "nouveau" ];
      xkbOptions = "caps:escape";
      libinput.enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      desktopManager.gnome.enable = true;
    };
    blueman.enable = true;
    gnome = {
      core-os-services.enable = true;
      core-shell.enable = true;
    };
    flatpak.enable = true;
    fprintd.enable = true;
    redshift.enable = true;
    pipewire = {
      enable = true;
      media-session.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
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
    };
  };

  sound.enable = true;
}
