{ inputs
, pkgs
, lib
, config
, uid ? 1000
, gid ? uid
, username
, group ? username
, homeDirectory ? if pkgs.parsedSystem.isLinux then
    "/home/${username}"
  else if pkgs.parsedSystem.isDarwin then
    "/Users/${username}"
  else
    abort "Cannot infer homeDirectory"
, initialHashedPassword ? ""
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
  config = lib.mkMerge [
    {
      users.users.${username} = {
        name = username;
        home = homeDirectory;
      };
      home-manager = {
        useGlobalPkgs = true;
        # useUserPackages = true;
        extraSpecialArgs = {
          inherit inputs username homeDirectory;
          lib = lib // inputs.home-manager.lib;
          nixosConfig = config;
        };
        users.${username} = import ./home.nix { inherit inputs pkgs lib username homeDirectory; };
      };
    }
    (lib.mkIf pkgs.parsedSystem.isLinux {
      users.users.${username} = {
        inherit uid group initialHashedPassword extraGroups;
        isNormalUser = true;
        isSystemUser = false;
        createHome = true;
        openssh.authorizedKeys.keys = sshKeys;
      };
      users.groups.${group} = { inherit gid; };
    })
  ];
}
