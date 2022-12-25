{ inputs, pkgs, ... }@args:

{
  imports = with inputs; [
    (import self.profiles.users.common (args // {
      username = "rekk";
    }))
    ./system
  ];
  home-manager.users.rekk = import ./home.nix;
}
