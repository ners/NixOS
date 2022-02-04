{ inputs, ... }:

{
  imports = with inputs; [
    self.nixosProfiles.users.common
  ];

  home-manager.users.ners = import ./home.nix;
}
