{ config, pkgs, ... }:

{
  home.packages = [
    (pkgs.unstable.vscode-with-extensions.override {
      vscodeExtensions = with pkgs.unstable.vscode-extensions; [
        arrterian.nix-env-selector
        haskell.haskell
        jnoortheen.nix-ide
        justusadam.language-haskell
        matklad.rust-analyzer
        ms-vsliveshare.vsliveshare
        vscodevim.vim
      ];
    })
  ];
}
