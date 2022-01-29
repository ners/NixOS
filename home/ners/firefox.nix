{ config, pkgs, ... }:

let
  firefox = pkgs.firefox-devedition-bin-unwrapped.overrideAttrs (oldAttrs: {
    installPhase = (oldAttrs.installPhase or "") + ''
      ln -s $out/bin/firefox $out/bin/firefox-devedition-bin-unwrapped
    '';
  });
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox firefox {
      forceWayland = true;
      extraPolicies = {
        ExtensionSettings = { };
      };
    };
  };
}
