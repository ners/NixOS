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
		initrd.kernelModules = [ "amdgpu" ];
		extraModulePackages = [ ];
		loader = {
				systemd-boot.enable = true;
				timeout = 3;
				efi = {
					canTouchEfiVariables = true;
					efiSysMountPoint = "/boot/efi";
				};
		};
		kernelModules = [ "fuse" "kvm-amd" "kvm-intel" ];
		
		/*fuck spectre and meltdown*/
		/* #makelinuxgreatagain */
		kernelParams = [
			"security=selinux"
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

		kernelPatches = [ {
			name = "selinux-config";
			patch = null;
			extraConfig = ''
				SECURITY_SELINUX y
				SECURITY_SELINUX_BOOTPARAM n
				SECURITY_SELINUX_DISABLE n
				SECURITY_SELINUX_DEVELOP y
				SECURITY_SELINUX_AVC_STATS y
				SECURITY_SELINUX_CHECKREQPROT_VALUE 0
				DEFAULT_SECURITY_SELINUX n
			'';
			}
		];
	};

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
		"/boot/efi" = {
			device = "/dev/disk/by-label/EFI";
			fsType = "vfat";
		};
	};

	swapDevices = [
		# "/dev/disk/by-label/swap"
	];

	nix.maxJobs = lib.mkDefault 8;
	powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

	hardware.opengl = {
		enable = true;
		driSupport = true;
		driSupport32Bit = true;
		extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
		setLdLibraryPath = true;
	};

	hardware.cpu.intel.updateMicrocode = true;
	hardware.pulseaudio.enable = true;

	services.xserver.videoDrivers = [ "amdgpu" ];
}
