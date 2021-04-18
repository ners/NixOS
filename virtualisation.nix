{ config, pkgs, ... }:
{
	virtualisation = {
		podman.enable = true;
		libvirtd.enable = true;
	};
	
	environment.systemPackages = with pkgs; [
		virt-manager
	];

	boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
}
