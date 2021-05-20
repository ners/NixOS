{ config, lib, pkgs, modulesPath, ... }:
{
	imports = [
		(modulesPath + "/installer/scan/not-detected.nix")
	];
	
	boot = {
		initrd.availableKernelModules = [
			"xhci_pci"
			"nvme"
			"usb_storage"
			"sd_mod"
			"rtsx_pci_sdmmc"
			"nouveau"
		];
		initrd.kernelModules = [ ];
		extraModulePackages = [ ];
		loader = {
		};
		kernelModules = [ "amdgpu" "fuse" ];
		
		/*fuck spectre and meltdown*/
		/* #makelinuxgreatagain */
		kernelParams = [
			"noibrs"
			"noibpb"
			"nopti"
			"nospectre_v2"
			"nospectre_v1"
			"l1tf=off"
			"nospec_store_bypass_disable"
			"no_stf_barrier"
			"mds=off"
			"tsx=on"
			"tsx_async_abort=off"
			"mitigations=off"
		];

	};
	
	powerManagement = {
		enable = true;
		cpuFreqGovernor = lib.mkDefault "performance";
	};

	hardware.opengl = {
		enable = true;
		driSupport = true;
		driSupport32Bit = true;
		extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
		setLdLibraryPath = true;
	};

	hardware.cpu.intel.updateMicrocode = true;
}
