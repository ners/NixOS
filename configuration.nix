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
	boot.loader.grub = {
		device = "nodev";
		efiSupport = true;
		enable = true;
		fsIdentifier = "label";
		gfxmodeEfi = "1920x1080";
		theme = pkgs.nixos-grub2-theme;
	};
	
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
			videoDrivers = [ "nouveau" ];
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
		udev.packages = with pkgs; [ gnome3.gnome-settings-daemon ];
		dbus.packages = with pkgs; [ fprintd gnome3.dconf gnome3.gvfs ];
		flatpak.enable = true;
		fprintd.enable = true;
		fwupd.enable = true;
		gvfs.enable = true;
		localtime.enable = true;
		openssh.enable = true;
		pipewire.enable = true;
		printing.enable = true;
		redshift.enable = true;
	};
	xdg.portal.enable = true;

	systemd.package = pkgs.systemd.override { withSelinux = true; };
	systemd.packages = with pkgs; [ fprintd gnome3.gvfs ];

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
			createHome = true;
			initialHashedPassword = "$6$P8pZJbrdjFXP7Bkf$CSxDmrTTO6o5pWUVXW0hy/c.Zdf7WtzNOPk1KiEDrDtyDf8x6V.ZvSzhh8kJWx0DKpObq4077SH1BRZZ0wgU/0";
			extraGroups = [ "audio" "libvirtd" "networkmanager" "video" "wheel" "dialout" ];
		};
	};

	environment = {
		systemPackages = with pkgs; [
			aria2
			boxes
			direnv
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
			nix-direnv
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
		pathsToLink = [ "/share/nix-direnv" ];
	};

	fonts = {
		fontconfig.enable = true;
		enableFontDir = true;
		enableGhostscriptFonts = true;
		fonts = with pkgs; [
			(nerdfonts.override { fonts = [ "RobotoMono" ]; })
			corefonts
			dejavu_fonts
			inconsolata
			inter
			inter-ui
			noto-fonts
			noto-fonts-emoji
			noto-fonts-extra
			roboto
			roboto-mono
			source-code-pro
			source-sans-pro
			source-serif-pro
            carlito
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

	networking.firewall.enable = false;

	system.stateVersion = "21.03";
}

