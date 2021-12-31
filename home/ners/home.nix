{ config, pkgs, ... }:

let unstable = import <nixos-unstable> { config.allowUnfree = true; };
in rec {
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
    packageOverrides = pkgs: {
      unstable = unstable;
      local = import "${home.homeDirectory}/Projects/nixpkgs" {}; };
  };

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

  imports = [
    ./apps.nix
    ./dconf.nix
    ./fonts.nix
    ./neovim
    ./shell.nix
    ./sway.nix
    ./vscode.nix
  ];

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
    graphviz
    httpie
    inkscape
    jdk11
    libguestfs-with-appliance
    libreoffice-fresh
    neofetch
    nodejs
    pavucontrol
    perl534Packages.FileMimeInfo
    rhythmbox
    subversion
    transmission-gtk
    transmission-remote-gtk
    universal-ctags
    unstable.chromium
    unstable.darktable
    unstable.discord
    unstable.foliate
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
      pull.rebase = true;
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

  home.file.".face".source = ./images/ners.jpg;
  home.file.".background".source = ./images/nix-wallpaper-nineish-dark-gray.png;
}
