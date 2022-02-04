{ pkgs, ... }:

{
  home.packages = with pkgs; [ calibre wineWowPackages.stable ];
}
