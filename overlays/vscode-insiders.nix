{ inputs, ... }:

self: super: {
  vscode-insiders = inputs.vscodeInsiders.packages.${super.system}.vscodeInsiders;
  vscode-insiders-with-extensions = super.vscode-with-extensions.override {
    vscode = self.vscode-insiders;
  };
  vscode-insiders-extensions = super.vscode-extensions;
}
