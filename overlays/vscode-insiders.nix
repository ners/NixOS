{ inputs, ... }:

let
  packageJson = builtins.fromJSON (builtins.readFile "${inputs.vscodeInsiders}/resources/app/package.json");
in
self: super: {
  vscode-insiders = (super.vscode.override { isInsiders = true; }).overrideAttrs (attrs: {
    src = inputs.vscodeInsiders;
    version = packageJson.version;
  });
  vscode-insiders-with-extensions = super.vscode-with-extensions.override {
    vscode = self.vscode-insiders;
  };
  vscode-insiders-extensions = super.vscode-extensions;
}
