{ config, pkgs, ... }:
let
	unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
	unstableOverride = import ( unstableTarball ) { config = config.nixpkgs.config; };
in
{
	imports = [
		./bootloader.nix
		./btrfs.nix
		./dvorak.nix
		./firefox-nightly.nix
		./gnome.nix
		./hardware-configuration.nix
		./pipewire.nix
		./selinux.nix
		./sway.nix
		./vim.nix
		./virtualisation.nix
		./zsh.nix
	];

	nix = {
		autoOptimiseStore = true;
		gc = {
			automatic = true;
			dates = "weekly";
			options = "--delete-older-than 30d";
		};
		maxJobs = 16;
		extraOptions = ''
			binary-caches-parallel-connections = 50
			keep-outputs = true
			keep-derivations = true
		'';
	};

	nixpkgs.config = {
		allowUnfree = true;
		allowBroken = false;
		packageOverrides = pkgs: {
			unstable = unstableOverride;
		};
	};

	networking = {
		hostName = "nixos";
		networkmanager.enable = true;
		useNetworkd = true;
	};

	# Select internationalisation properties.
	i18n = {
		defaultLocale = "en_GB.UTF-8";
	};
	console = {
		font = "Lat2-Terminus16";
	};

	services = {
		xserver = {
			enable = true;
			videoDrivers = [ "amdgpu" ];
			xkbOptions = "caps:escape";
			libinput.enable = true;
		};
		flatpak.enable = true;
		fprintd.enable = true;
		fwupd.enable = true;
		localtime.enable = true;
		openssh.enable = true;
		printing.enable = true;
		redshift.enable = true;
	};

	security = {
		rtkit.enable = true;
		pam.services = {
			login.fprintAuth = true;
			xscreensaver.fprintAuth = true;
			};
	};

	users = {
		users.root = {
			initialHashedPassword = "";
		};
		users.ners = {
			isNormalUser = true;
			createHome = true;
			initialHashedPassword = "$6$P8pZJbrdjFXP7Bkf$CSxDmrTTO6o5pWUVXW0hy/c.Zdf7WtzNOPk1KiEDrDtyDf8x6V.ZvSzhh8kJWx0DKpObq4077SH1BRZZ0wgU/0";
			extraGroups = [ "audio" "libvirtd" "networkmanager" "video" "wheel" "dialout" ];
		};
	};

	environment = {
		systemPackages = with pkgs; [
			aria2
			entr
			exfat
			expect
			file
			flatpak-builder
			fprintd
			gitAndTools.gitFull
			gnumake
			htop
			httpie
			jq
			killall
			libsecret
			moreutils
			mpv
			nix-index
			nodejs
			pciutils
			pv
			silver-searcher
			sshfs-fuse
			subversion
			tio
			tmux
			tree
			usbutils
			wget
			wineWowPackages.stable
			winetricks
		];
	};

	networking.firewall.enable = false;

	system.stateVersion = "21.03";
}

