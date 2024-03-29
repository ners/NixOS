# PR-like view
odiff () {
    git diff origin/master...origin/$1
}

makeshell() {
    basicshell="
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = [
    texlive.combined.scheme-basic
  ];
}
"
    touch shell.nix
    echo $basicshell >> shell.nix
}

makeflake() {
    basicflake="
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs:
    with inputs;
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in { devShell = pkgs.mkShell { nativeBuildInputs = []; }; });
}
    "

    touch flake.nix
    touch .envrc
    echo $basicflake >> flake.nix
    echo "use flake" >> .envrc
}

# file system shortcuts
hash -d pr=$HOME/projects
hash -d me=$HOME/projects/meatico
hash -d fe=$HOME/projects/meatico/js/backoffice
hash -d be=$HOME/projects/meatico/backend
hash -d bd=$HOME/projects/meatico/base_data
hash -d nix=$HOME/projects/macos/nixpkgs

# aliases
alias vimr="/Applications/VimR.app/Contents/MacOS/VimR --cur-env . &"
alias remove_gql_codegen='find -X . -name "*.generated.ts" | xargs rm'
alias darwin_rebuild="pushd ~/Projects/NixOS && darwin-rebuild build --flake . && result/sw/bin/darwin-rebuild switch --flake . && popd"
alias git_list_assume_unchanged="git ls-files -v | grep '^[[:lower:]]'"
alias kill_docker="docker rm -f $(docker ps -a -q) > /dev/null 2>/dev/null"
alias ports_listening="sudo lsof -i -P | grep LISTEN"
alias neovide="/Applications/Neovide.app/Contents/MacOS/neovide --frame none"
alias mpv_gui="mpv --player-operation-mode=pseudo-gui"

# export PATH="$PATH:/opt/homebrew/opt/llvm/bin"
# export PATH="$PATH:/Users/rekk/.local/bin"
#
bindkey "^I" fzf-tab-complete
