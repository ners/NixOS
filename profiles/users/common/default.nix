{ inputs
, pkgs
, lib
, config
, uid ? 1000
, gid ? uid
, username
, group ? username
, homeDirectory ? "/home/${username}"
, initialHashedPassword
, extraGroups ? [
    "audio"
    "dialout"
    "docker"
    "libvirtd"
    "networkmanager"
    "plugdev"
    "users"
    "video"
    "wheel"
  ]
, sshKeys ? [ ]
, ...
}:

{
  imports = [ inputs.home-manager.nixosModule ];

  users.users.${username} = {
    inherit uid group initialHashedPassword extraGroups;
    isNormalUser = true;
    isSystemUser = false;
    createHome = true;
    openssh.authorizedKeys.keys = sshKeys;
  };
  users.groups.${group} = { inherit gid; };

  home-manager = {
    useGlobalPkgs = true;
    # useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs username homeDirectory;
      lib = lib // inputs.home-manager.lib;
      nixosConfig = config;
    };
    users.${username} = import ./home.nix;
  };
}
