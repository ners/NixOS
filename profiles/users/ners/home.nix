{ config, pkgs, ... }:

{
  imports = [
    ./calibre.nix
    ./fonts.nix
    ./git.nix
    ./sway
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    audacity
    bintools
    cabal2nix
    element-desktop
    ffmpeg
    flatpak
    fractal
    gimp
    gitg
    graphviz
    inkscape
    libguestfs-with-appliance
    libreoffice-fresh
    nodejs
    pavucontrol
    tmate
    transmission-remote-gtk
    unstable.chromium
    unstable.darktable
    unstable.discord
    unstable.drawio
    unstable.firefox-devedition-wayland
    unstable.foliate
    unstable.ngrok
    unstable.nushell
    unstable.plexamp
    unstable.slack
    unstable.sweethome3d.application
    unstable.tdesktop
    unstable.zoom-us
    v4l-utils
    winbox
  ];

  home.sessionVariables = {
    BROWSER = "firefox";
    CABAL_CONFIG = "$HOME/.config/cabal/config";
    EDITOR = "nvim";
    FZF_ALT_C_COMMAND = "fd -t d . /home";
    FZF_CTRL_T_COMMAND = "fd . /home";
    FZF_DEFAULT_COMMAND = "fd . /home";
    GIT_SSH_COMMAND = "ssh -F \\$HOME/.ssh/config";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    VISUAL = "nvim-qt";
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
