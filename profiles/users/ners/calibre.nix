{ pkgs, ... }:

{
  home.packages = with pkgs; [ calibre wine ];
}
