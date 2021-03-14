{ config, pkgs, ... }:

let
	unstableTarball = fetchTarball
		https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
	unstable = import ( unstableTarball ) { config = config.nixpkgs.config; };
in
{
	imports = [
		./hardware-configuration.nix
		./dvorak.nix
		./sway.nix
		./zsh.nix
	];

	boot.kernelPackages = pkgs.linuxPackages_latest;
	boot.loader.grub.theme = pkgs.nixos-grub2-theme;
	
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
		'';
	};

	nixpkgs.config = {
		allowUnfree = true;
		allowBroken = false;
		packageOverrides = pkgs: {
			unstable = import unstableTarball {
				config = config.nixpkgs.config;
			};
		};
		firefox = {
			# enableAdobeFlash = true;
			enableGnomeExtensions = true;
		};
	};

	networking = {
		hostName = "nixos";
		networkmanager.enable = true;
		useNetworkd = true;
	};

	# Set your time zone.
	time.timeZone = "Europe/Zurich";

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
			displayManager = {
				gdm = {
					enable = true;
					wayland = true;
				};
			};
			desktopManager.gnome3.enable = true;
			xkbOptions = "caps:escape";
			libinput.enable = true;
		};
		dbus.packages = with pkgs; [ fprintd gnome3.dconf ];
		udev.packages = with pkgs; [ gnome3.gnome-settings-daemon ];
		flatpak.enable = true;
		fprintd.enable = true;
		fwupd.enable = true;
		openssh.enable = true;
		printing.enable = true;
		pipewire.enable = true;
		redshift.enable = true;
	};
	xdg.portal.enable = true;

	systemd.package = pkgs.systemd.override { withSelinux = true; };
	systemd.packages = with pkgs; [ fprintd ];

	security.pam.services = {
		login.fprintAuth = true;
		xscreensaver.fprintAuth = true;
	};

	virtualisation = {
		podman.enable = true;
		libvirtd.enable = true;
	};

	sound.enable = true;
	powerManagement.enable = true;

	users = {
		users.root = {
			initialHashedPassword = "";
		};
		users.ners = {
			isNormalUser = true;
			initialHashedPassword = "$6$P8pZJbrdjFXP7Bkf$CSxDmrTTO6o5pWUVXW0hy/c.Zdf7WtzNOPk1KiEDrDtyDf8x6V.ZvSzhh8kJWx0DKpObq4077SH1BRZZ0wgU/0";
			extraGroups = [ "audio" "libvirtd" "networkmanager" "video" "wheel" ];
		};
	};

	environment = {
		systemPackages = with pkgs; [
			any-nix-shell
			aria2
			boxes
			entr
			exfat
			expect
			file
			fprintd
			gimp
			gitAndTools.gitFull
			gnome3.adwaita-icon-theme
			gnome3.eog
			gnome3.evince
			gnome3.gnome-boxes
			gnome3.gnome-tweak-tool
			gnome3.gvfs
			gnome3.networkmanagerapplet
			gnomeExtensions.appindicator
			gnumake
			grml-zsh-config
			htop
			httpie
			jq
			killall
			libappindicator
			libreoffice
			libsecret
			libselinux
			moreutils
			mpv
			neovim
			neovim-qt
			nix-index
			nix-zsh-completions
			pavucontrol
			policycoreutils
			silver-searcher
			sshfs-fuse
			starship
			thunderbird
			tio
			tmux
			unstable.calibre
			unstable.firefox-wayland
			unstable.vimPlugins.vim-nerdtree-syntax-highlight
			vimPlugins.base16-vim
			vimPlugins.coc-git
			vimPlugins.coc-nvim
			vimPlugins.haskell-vim
			vimPlugins.nerdtree
			vimPlugins.sved
			vimPlugins.vim-devicons
			vimPlugins.vim-nix
			virt-manager
			wget
			wineWowPackages.stable
			winetricks
			zsh
			zsh-autosuggestions
			zsh-completions
			zsh-syntax-highlighting
		];
		variables = {
			EDITOR = "nvim";
			VISUAL = "nvim-qt";
		};
	};

	fonts = {
		fontconfig.enable = true;
		enableFontDir = true;
		enableGhostscriptFonts = true;
		fonts = with pkgs; [
			corefonts
			dejavu_fonts
			inconsolata
			inter
			inter-ui
			(nerdfonts.override { fonts = [ "RobotoMono" ]; })
			noto-fonts
			noto-fonts-extra
			noto-fonts-emoji
			roboto
			roboto-mono
			source-code-pro
			source-sans-pro
			source-serif-pro
		];
		fontconfig.defaultFonts = {
			sansSerif = ["Arimo"];
			serif = ["Tinos"];
			monospace = ["Cousine"];
			emoji = ["Noto Color Emoji"];
		};
	};

	programs = {
		dconf.enable = true;
		mtr.enable = true;
		gnupg.agent = {
		  enable = true;
		  enableSSHSupport = true;
		};
		nm-applet.enable = true;
	};

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "20.09"; # Did you read the comment?
}

