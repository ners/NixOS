{ inputs
, pkgs
, lib
, ...
}@args:

let
  uid = args.uid or 1000;
  gid = args.gid or 1000;
  username = args.username or "ners";
  group = args.group or username;
  homeDirectory = args.homeDirectory or "/home/${username}";
  initialHashedPassword = args.initialHashedPassword or "$6$P8pZJbrdjFXP7Bkf$CSxDmrTTO6o5pWUVXW0hy/c.Zdf7WtzNOPk1KiEDrDtyDf8x6V.ZvSzhh8kJWx0DKpObq4077SH1BRZZ0wgU/0";
  extraGroups = args.extraGroups or [
    "audio"
    "dialout"
    "docker"
    "libvirtd"
    "networkmanager"
    "plugdev"
    "users"
    "video"
    "wheel"
  ];
  sshKeys = args.sshKeys or [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINBlAx5Hi5TsLsy5e+4OdBmM4oHtdUnqX5gtNbfc60rq ners"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMxceZEJ4aQXkvHWWDh5TXNk9XdpIZFQKGhQGAZIeLxr rekk"
  ];
in
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
    };
    users.${username} = import ./home.nix;
  };
}
