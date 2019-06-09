{ config, pkgs, ... }:

{
	imports = [ ./hardware-configuration.nix ];

	boot = {
		loader = {
			systemd-boot.enable = true;
			grub = {
				enable = true;
				version = 2;
				efiSupport = true;
				device = "nodev";
				fsIdentifier = "label";
				splashMode = "stretch";
			};
			efi = {
				canTouchEfiVariables = true;
				efiSysMountPoint = "/boot/efi";
			};
		};
	};

	networking = {
		hostName = "nixos";
		networkmanager.enable = true;
	};

	i18n = {
		 consoleFont = "Lat2-Terminus16";
		 consoleKeyMap = "us";
		 defaultLocale = "en_GB.UTF-8";
	};

	time.timeZone = "Europe/Zurich";

	nixpkgs.config = {
		allowUnfree = true;
		allowBroken = false;
	};

	environment = {
		shells = [
			"${pkgs.bash}/bin/bash"
			"${pkgs.zsh}/bin/zsh"
		];
		variables = {
			TERM = "xterm-256color";
			LC_ALL = "en_GB.UTF-8";
			LESSCHARSET = "utf-8";
			BROWSER = pkgs.lib.mkOverride 0 "firefox";
			EDITOR = pkgs.lib.mkOverride 0 "vim";
		};
		systemPackages = with pkgs; [
			firefox
			git
			httpie
			tmux
			vimHugeX
			wget
			sway swayidle swaylock
			zsh grml-zsh-config zsh-syntax-highlighting
		];
	};

	fonts = {
		enableCoreFonts = true;
		enableFontDir = true;
		enableGhostscriptFonts = false;
		fonts = with pkgs; [
			corefonts
			inconsolata
			source-code-pro
		];
	};

	programs = {
		bash = {
			enableCompletion = true;
		};
		zsh = {
			enable = true;
			enableCompletion = true;
			syntaxHighlighting.enable = true;
			interactiveShellInit = ''
				source ${pkgs.grml-zsh-config}/etc/zsh/zshrc
			'';
		};
		gnupg = {
			agent = {
				enable = true;
				enableSSHSupport = true;
			};
		};
		ssh = {
		};
		sway.enable = true;
	};

	services = {
		openssh.enable = true;
		printing.enable = true;
	};

	sound.enable = true;
	hardware.pulseaudio.enable = true;

	users.users.ners = {
		isNormalUser = true;
		shell = pkgs.zsh;
		extraGroups = [ "docker" "libvirtd" "networkmanager" "sway" "wheel" ];
	};

	nix.maxJobs = 32;
	nix.buildCores = 8;
	system.stateVersion = "19.03";
}
