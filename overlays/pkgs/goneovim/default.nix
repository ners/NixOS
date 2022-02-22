{ lib, fetchFromGitHub, buildGoPackage }:

let
  pname = "goneovim";
  version = "0.5.1";
  owner = "akiyosi";
  repo = pname;
  rev = "v${version}";
in
buildGoPackage {
  inherit pname version rev;

  goPackagePath = "github.com/${owner}/${repo}";

  src = fetchFromGitHub {
    inherit owner repo rev;
    sha256 = "sha256-dbdPvbIPpMaPl8RkM/s9X8pG8KGbzz53xnor+LNCOwY=";
  };

  goDeps = ./deps.nix;

  meta = {
    license = lib.licenses.mit;
    homepage = "https://github.com/${owner}/${repo}";
    description = "Neovim GUI written in Golang, using a Golang qt backend";
  };
}
