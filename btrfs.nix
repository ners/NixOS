{ config, pkgs, ... }:
{
	fileSystems = {
		"/" = {
			device = "/dev/disk/by-label/NixOS";
			fsType = "btrfs";
			options = [ "subvol=root" "compress=zstd" ];
		};
		"/home" = {
			device = "/dev/disk/by-label/NixOS";
			fsType = "btrfs";
			options = [ "subvol=home" "compress=zstd" ];
		};
		"/swap" = {
			device = "/dev/disk/by-label/NixOS";
			fsType = "btrfs";
			options = [ "subvol=swap" "compress=no" ];
		};
	};

	swapDevices = [ { device = "/swap/swapfile"; size = 4096; } ];
	
	environment.systemPackages = with pkgs; [
		btrfs-progs
		compsize
	];
}
