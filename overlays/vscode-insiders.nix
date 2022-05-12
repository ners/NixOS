{ inputs, ... }:

self: super: {
  vscode-insiders = inputs.vscodeInsiders.packages.${super.system}.vscodeInsiders;
  vscode-insiders-with-extensions = super.vscode-with-extensions.override {
    vscode = self.vscode-insiders;
  };
  vscode-extensions = super.vscode-extensions // {
    ms-vsliveshare = super.vscode-extensions.ms-vsliveshare // {
      vsliveshare = super.vscode-extensions.ms-vsliveshare.vsliveshare.override {
        dotnet-sdk_3 = super.dotnet-sdk_5;
      };
    };
  };
}
