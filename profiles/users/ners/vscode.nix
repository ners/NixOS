{ pkgs, ... }:

{
  home.packages = [
    (pkgs.master.vscode-insiders-with-extensions.override {
      vscodeExtensions = with pkgs.master.vscode-insiders-extensions; [
        arrterian.nix-env-selector
        bierner.markdown-mermaid
        haskell.haskell
        jnoortheen.nix-ide
        justusadam.language-haskell
        #matklad.rust-analyzer
        ms-azuretools.vscode-docker
        ms-vscode.cpptools
        ms-vsliveshare.vsliveshare
        serayuzgur.crates
        vscodevim.vim
        zxh404.vscode-proto3
        #asvetliakov.vscode-neovim
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "cmake-tools";
          publisher = "ms-vscode";
          version = "1.12.22";
          sha256 = "sha256-noQ0JRmfDdbF3voMOg0MY8okULC1us9VhslTHgS+Vck=";
        }
        {
          name = "makefile-tools";
          publisher = "ms-vscode";
          version = "0.5.0";
          sha256 = "sha256-oBYABz6qdV9g7WdHycL1LrEaYG5be3e4hlo4ILhX4KI=";
        }
      ];
    })
  ];
}
