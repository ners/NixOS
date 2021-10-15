{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { };
  nix-env-selector = (unstable.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "nix-env-selector";
      publisher = "arrterian";
      version = "1.0.7";
      sha256 = "sha256:0mralimyzhyp4x9q98x3ck64ifbjqdp8cxcami7clvdvkmf8hxhf";
    };
  });
in {
  home.packages = [
    (unstable.vscode-with-extensions.override {
      vscodeExtensions = with unstable.vscode-extensions; [
        haskell.haskell
        jnoortheen.nix-ide
        justusadam.language-haskell
        ms-vsliveshare.vsliveshare
        nix-env-selector
        vscodevim.vim
      ];
    })
  ];
}
