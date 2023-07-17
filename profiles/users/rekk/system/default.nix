{ pkgs, lib, ... }:

{
  config = lib.optionalAttrs pkgs.parsedSystem.isDarwin {
    system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
    system.defaults.NSGlobalDomain.KeyRepeat = 1;

    system.defaults.".GlobalPreferences"."com.apple.mouse.scaling" = "1";

    system.defaults.dock.autohide = true;

    system.defaults.trackpad.Clicking = true;

    system.keyboard.enableKeyMapping = true;
    system.keyboard.remapCapsLockToEscape = true;

      system.activationScripts.extraActivation.text = ''
        # ⌘ + M no longer minimises windows
        defaults write -g NSUserKeyEquivalents -dict-add "Im Dock ablegen" "\0"

        # Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
        defaults write com.apple.finder QuitMenuItem -bool true

        # Finder: show hidden files by default
        defaults write com.apple.finder AppleShowAllFiles -bool true

        # When performing a search, search the current folder by default
        defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
        '';
  };
}
