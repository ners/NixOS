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
    stateVersion = inputs.self.nixosVersion;
  };

  imports = [
    ./apps.nix
    ./dconf.nix
    ./neovim
    ./shell
    ./xdg
  ];

  services.udiskie.enable = true;
}