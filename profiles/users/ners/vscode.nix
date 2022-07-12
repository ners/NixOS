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
        matklad.rust-analyzer
        ms-azuretools.vscode-docker
        ms-vsliveshare.vsliveshare
        serayuzgur.crates
        vscodevim.vim
        #asvetliakov.vscode-neovim
        zxh404.vscode-proto3
      ];
    })
  ];
}
