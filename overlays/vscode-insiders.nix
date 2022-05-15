{ inputs, ... }:

self: super: {
  vscode-insiders = inputs.vscodeInsiders.packages.${super.system}.vscodeInsiders;
  vscode-insiders-with-extensions = super.vscode-with-extensions.override {
    vscode = self.vscode-insiders;
  };
  vscode-insiders-extensions = super.vscode-extensions // {
    ms-vsliveshare = super.vscode-extensions.ms-vsliveshare // {
      vsliveshare = super.vscode-extensions.ms-vsliveshare.vsliveshare.override {
        inherit (let
          nixpkgs = super.fetchFromGitHub {
            owner = "nixos";
            repo = "nixpkgs";
            rev = "nixos-21.11";
            sha256 = "sha256-GWRrbUv9l1GSyBkj39s9AqNLX1l3rzVOwvnuG4WYM+E=";
          };
          pkgs = import nixpkgs { };
        in
        pkgs) dotnet-sdk_3;
      };
    };
  };
}
