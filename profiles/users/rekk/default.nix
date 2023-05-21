{ inputs, ... }@args:

{
  imports = with inputs; [
    (import self.profiles.users.common (args // {
      uid = 1001;
      username = "rekk";
    }))
    ./system
  ];
  home-manager.users.rekk = import ./home.nix;
}
