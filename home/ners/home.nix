{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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
  home.stateVersion = "21.05";

  imports = [ ./neovim.nix ./shell.nix ./sway.nix ];

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Cousine" "RobotoMono" ]; })
    aria2
    boxes
    cabal2nix
    entr
    flatpak-builder
    gitg
    httpie
    mpv
    nix-index
    nodejs
    pciutils
    subversion
    transmission-remote-gtk
    unzip
    v4l-utils
    wineWowPackages.stable
    winetricks
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
    };
  };

  xdg.configFile."cabal/config".text = ''
    nix: True
    jobs: $ncpus
  '';

}
