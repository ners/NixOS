{ config, pkgs, ... }:

let unstable = import <nixos-unstable> { config.allowUnfree = true; };
in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = false;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ners";
  home.homeDirectory = "/home/ners";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  imports = [ ./fonts.nix ./neovim.nix ./shell.nix ./sway.nix ./vscode.nix ];

  home.packages = with pkgs; [
    (import ../../packages/winbox)
    aria2
    audacity
    bat
    boxes
    cabal2nix
    calibre
    element-desktop
    entr
    flatpak
    flatpak-builder
    fractal
    gimp
    git-lfs
    gitg
    httpie
    inkscape
    jdk11
    libguestfs-with-appliance
    libreoffice-fresh
    mpv
    neofetch
    nix-index
    nodejs
    pavucontrol
    pciutils
    subversion
    transmission-gtk
    transmission-remote-gtk
    universal-ctags
    unstable.chromium
    unstable.darktable
    unstable.discord
    unstable.librecad
    unstable.plexamp
    unstable.skype
    unstable.slack
    unstable.sweethome3d.application
    unstable.tdesktop
    unstable.zoom-us
    unzip
    v4l-utils
    x2goclient
  ];

  programs.git = {
    enable = true;
    userName = "ners";
    userEmail = "ners@gmx.ch";
    ignores = [ ".*" "!.envrc" "!.gitignore" ];
    extraConfig = {
      core = {
        init.defaultBranch = "master";
        sshCommand = "ssh -F $HOME/.ssh/config";
      };
      push.default = "current";
      credential.helper = "libsecret";
      "filter \"lfs\"" = {
        required = true;
        clean = "git-lfs clean -- %f";
        process = "git-lfs filter-process";
        smudge = "git-lfs smudge -- %f";
      };
    };
  };

  services.udiskie.enable = true;

  xdg.configFile."cabal/config".text = ''
    nix: True
    jobs: $ncpus
  '';

  xdg.configFile."libvirt/qemu.conf".text = ''
    nvram = ["/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd"]
  '';

  home.file.".face".source = ./images/ners.jpg;
  home.file.".background".source = ./images/nix-wallpaper-nineish-dark-gray.png;
  dconf.settings = {
    "org/gnome/desktop/background" = { "picture-uri" = ".background"; };
    "org/gnome/desktop/screensaver" = { "picture-uri" = ".background"; };
  };
}
