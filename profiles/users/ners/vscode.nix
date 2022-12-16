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
        #vscodevim.vim
        zxh404.vscode-proto3
        ms-vscode.makefile-tools
        ms-vscode.cmake-tools
        asvetliakov.vscode-neovim
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      ];
    })
  ];
}
