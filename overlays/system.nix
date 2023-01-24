{ lib, ... }:

self: super:
let
  parsedSystem = lib.systems.parse.mkSystemFromString self.system;
  isLinux = parsedSystem.kernel.name == "linux";
  isDarwin = parsedSystem.kernel.name == "darwin";
in
{
  parsedSystem = parsedSystem // {
    inherit isLinux isDarwin;
  };
}
