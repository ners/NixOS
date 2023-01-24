{pkgs, ...}:

{
  programs.firefox = {
    enable = true;
    package = pkgs.unstable.firefox-devedition-bin;
  };
}
