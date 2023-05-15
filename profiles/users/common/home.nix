{ inputs
, pkgs
, lib
, username
, homeDirectory
, ...
}:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = false;

  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    inherit username homeDirectory;

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = inputs.self.version;
  };

  # Home-manager's generation is currently broken
  # as it does not call modules with specialArgs.
  manual.manpages.enable = lib.mkForce false;

  imports = [
    ./apps.nix
    ./dconf.nix
    ./direnv.nix
    ./firefox.nix
    ./git.nix
    ./graphical.nix
    ./neovim
    ./starship.nix
    ./tmux.nix
    ./xdg
    ./zsh
    inputs.nix-colors.homeManagerModule
  ];

  colorScheme = inputs.nix-colors.colorSchemes.classic-light;

  services.udiskie.enable = pkgs.parsedSystem.isLinux;
}
