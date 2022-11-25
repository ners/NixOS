{ inputs, pkgs, lib, ... }:

{
  imports = with inputs; [
    self.profiles.nix
    self.profiles.zsh
  ];

  environment = {
    systemPackages = with pkgs; [
      aria2
      bat
      boxes
      btop
      entr
      exa
      exfat
      expect
      fd
      file
      fx
      jq
      killall
      libfaketime
      moreutils
      nano
      neofetch
      neovim
      nix-diff
      nix-index
      nix-top
      nix-tree
      unstable.nix-output-monitor
      nvd
      perl534Packages.FileMimeInfo
      pv
      ripgrep
      smartmontools
      sshfs-fuse
      tio
      tmux
      tree
      unzip
      wget
      xh
      zip
    ];
    variables = { EDITOR = "nvim"; };
  };
}
