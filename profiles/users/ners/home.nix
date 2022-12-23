{ config, pkgs, ... }:

{
  imports = [
    ./calibre.nix
    ./fonts.nix
    ./sway
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    audacity
    bintools
    cabal2nix
    ffmpeg
    flatpak
    gimp
    gitg
    graphviz
    inkscape
    libguestfs-with-appliance
    libreoffice-fresh
    pavucontrol
    tmate
    transmission-remote-gtk
    unstable.chromium
    unstable.darktable
    unstable.discord
    unstable.drawio
    unstable.element-desktop
    unstable.firefox-devedition-bin
    unstable.foliate
    unstable.ngrok
    unstable.nushell
    unstable.plexamp
    unstable.prusa-slicer
    unstable.signal-desktop
    unstable.slack
    unstable.sweethome3d.application
    unstable.tdesktop
    unstable.winbox
    unstable.zoom-us
    v4l-utils
  ];

  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    userName = "ners";
    userEmail = "ners@gmx.ch";
  };

  home.sessionVariables = {
    BROWSER = "firefox";
    CABAL_CONFIG = "$HOME/.config/cabal/config";
    EDITOR = "nvim";
    FZF_ALT_C_COMMAND = "fd -t d . /home";
    FZF_CTRL_T_COMMAND = "fd . /home";
    FZF_DEFAULT_COMMAND = "fd . /home";
    GIT_SSH_COMMAND = "ssh -F \\$HOME/.ssh/config";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    VISUAL = "neovide";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  services.udiskie.enable = true;

  home.file.".face".source = ./images/ners.jpg;
  home.file.".background".source = ./images/nix-wallpaper-nineish-dark-gray.png;
  dconf.settings = {
    "org/gnome/desktop/background" = { picture-uri = ".background"; };
    "org/gnome/desktop/screensaver" = { picture-uri = ".background"; };
  };
}
