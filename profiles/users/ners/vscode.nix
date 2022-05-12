{ config, lib, pkgs, ... }:

{
  home.packages = [
    (pkgs.unstable.vscode-insiders-with-extensions.override {
      vscodeExtensions = with pkgs.unstable.vscode-extensions; [
        arrterian.nix-env-selector
        haskell.haskell
        jnoortheen.nix-ide
        justusadam.language-haskell
        matklad.rust-analyzer
        matklad.rust-analyzer
        ms-azuretools.vscode-docker
        ms-vsliveshare.vsliveshare
        serayuzgur.crates
        vscodevim.vim
        zxh404.vscode-proto3
      ];
    })
  ];
}
