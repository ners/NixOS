{ config, pkgs, ... }:

{
	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;

	# Home Manager needs a bit of information about you and the
	# paths it should manage.
	home.username = "ners";
	home.homeDirectory = "/home/ners";

	# This value determines the Home Manager release that your
	# configuration is compatible with. This helps avoid breakage
	# when a new Home Manager release introduces backwards
	# incompatible changes.
	#
	# You can update Home Manager without changing this value. See
	# the Home Manager release notes for a list of state version
	# changes in each release.
	home.stateVersion = "21.05";

	home.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "Cousine" "RobotoMono" ]; })
		aria2
		boxes
		cabal2nix
		entr
		flatpak-builder
		haskellPackages.fourmolu
		httpie
		mpv
		nix-index
		nodejs
		pciutils
		subversion
		unzip
		v4l-utils
		wineWowPackages.stable
		winetricks
	];

	programs.alacritty = {
		enable = true;
		settings = {
			background_opacity = 0.9;
			font = {
				size = 11;
			};
		};
	};

	programs.git = {
		enable = true;
		userName = "ners";
		userEmail = "ners@gmx.ch";
		ignores = [ ".*" "!.envrc" "!.gitignore" ];
		extraConfig = {
			credential.helper = "libsecret";
		};
	};

	programs.direnv = {
		enable = true;
		nix-direnv.enable = true;
		enableZshIntegration = true;
	};

	programs.starship = {
		enable = true;
		enableZshIntegration = true;
	};

	programs.zsh = {
		enable = true;
		initExtra = ''
			bindkey "$terminfo[kcuu1]" history-substring-search-up
			bindkey "$terminfo[kcud1]" history-substring-search-down
			source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
		'';
		shellAliases = {
			open = "open() { xdg-open \"$@\" & disown }; open";
			gvim = "nvim-qt";
			make = "make -j$(nproc)";
			makevars = "make -pn | grep -A1 '^# makefile' | grep -v '^#\\|^--' | sort | uniq";
			scp = "scp -F $HOME/.ssh/config";
			ssh = "ssh -F $HOME/.ssh/config";
			sshfs = "sshfs -F $HOME/.ssh/config";
		};
	};
	home.sessionVariables = {
		CABAL_CONFIG = "$HOME/.config/cabal/config";
		GIT_SSH_COMMAND = "ssh -F \\$HOME/.ssh/config";
		MOZ_ENABLE_WAYLAND = "1";
	};

	programs.neovim = {
		enable = true;
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;
		withNodeJs = true;
		withPython3 = true;
		plugins = with pkgs.vimPlugins; [
			coc-clangd
			coc-json
			coc-nvim
			nerdtree
			nerdtree-git-plugin
			vim-code-dark
			vim-devicons
			vim-nerdtree-syntax-highlight
			vim-nix
		];
		extraConfig = ''
			set t_Co=256
			set t_ut=
			colorscheme codedark
			let g:airline_theme = 'codedark'
			set number
			set list listchars=tab:›\ ,trail:~,extends:»,precedes:«,nbsp:_
			set ts=4 sts=4 sw=4 noexpandtab
			set autoindent smartindent
			set incsearch hlsearch
			set ignorecase smartcase
			set splitright splitbelow
			filetype on
			syntax on
			filetype plugin on
			filetype indent on
			set autoread
			au FocusGained * :checktime
			let g:WebDevIconsUnicodeDecorateFolderNodes = 1
			let g:DevIconsEnableFoldersOpenClose = 1
			let g:DevIconsEnableFolderExtensionPatternMatching = 1
			let g:DevIconsDefaultFolderOpenSymbol='ﱮ'
			let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol=''
			let g:NERDTreeDirArrowExpandable = ""
			let g:NERDTreeDirArrowCollapsible = ""
			let g:NERDTreeAutoDeleteBuffer = 1
			let g:NERDTreeMinimalUI = 1
			let g:NERDTreeDirArrows = 0
			let g:NERDTreeGitStatusUseNerdFonts = 1
			let g:NERDTreeShowHidden=1
			autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
		'';
	};
	
	xdg.configFile."nvim/coc-settings.json".text = builtins.toJSON {
		diagnostic = {
			errorSign = "🔥";
			warningSign = "⚠️";
			infoSign = "ℹ️";
		};
		languageserver.haskell = {
			command = "haskell-language-server-wrapper";
			args = ["--lsp"];
			rootPatterns = ["*.cabal" "stack.yaml" "cabal.project" "package.yaml" "hie.yaml"];
			filetypes = ["haskell" "lhaskell"];
			initializationOptions = {
				haskell = {
					formattingProvider = "fourmolu";
				};
			};
		};
	};

	xdg.configFile."nvim/ginit.vim".text = ''
		GuiFont! Cousine Nerd Font:h11
		highlight LineNr guibg=NONE
		" highlight NonText guifg=bg
	'';
	
	xdg.configFile."cabal/config".text = ''
		nix: True
		jobs: $ncpus
	'';

	wayland.windowManager.sway = {
		enable = true;
		systemdIntegration = true;
		config = rec {
			modifier = "Mod4";
			terminal = "alacritty";
			menu = "swaymsg exec -- wofi --show drun --fork";
			fonts = {
				names = ["Inter"];
				style = "Regular";
				size = 11.0;
			};
			bars = [
				{ command = "waybar"; }
			];
			input = {
				"type:keyboard" = {
					xkb_layout = "us";
					xkb_variant = "dvorak";
					repeat_rate = "50";
					repeat_delay = "150";
					xkb_options = "caps:escape";
				};
				"type:touchpad" = {
					tap = "enabled";
					pointer_accel = "0.75";
				};
			};
			output = {
				"*" = {
					bg = "$(find ~/Pictures/Wallpapers/ -type f | shuf -n 1) fill";
				};
			};
			gaps = {
				smartGaps = true;
				outer = 0;
				inner = 10;
				bottom = 0;
			};
			window = {
				border = 1;
				hideEdgeBorders = "smart";
			};
			startup = [
				{
					command = ''
						swayidle -w \
							timeout 3000 screenlock \
							timeout 6000 'swaymsg \"output * dpms off\"' \
							resume 'swaymsg \"output * dpms on\"' \
							before-sleep screenlock
					'';
					always = false;
				}
				{
					command = "nm-applet --indicator";
					always = false;
				}
			];
			keybindings = {
				"${modifier}+Return" = "exec ${terminal}";
				"${modifier}+space" = "exec ${menu}";
				"${modifier}+Shift+r" = "reload";
				"${modifier}+Shift+apostrophe" = "kill";
				"${modifier}+l" = "screenlock";
				"${modifier}+Shift+f" = "fullscreen";
				"${modifier}+Shift+space" = "floating toggle";
				"${modifier}+Shift+Escape" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
				"${modifier}+1" = "workspace number 1";
				"${modifier}+2" = "workspace number 2";
				"${modifier}+3" = "workspace number 3";
				"${modifier}+4" = "workspace number 4";
				"${modifier}+5" = "workspace number 5";
				"${modifier}+6" = "workspace number 6";
				"${modifier}+7" = "workspace number 7";
				"${modifier}+8" = "workspace number 8";
				"${modifier}+9" = "workspace number 9";
				"${modifier}+0" = "workspace number 10";
				"${modifier}+Shift+1" = "move container to workspace number 1";
				"${modifier}+Shift+2" = "move container to workspace number 2";
				"${modifier}+Shift+3" = "move container to workspace number 3";
				"${modifier}+Shift+4" = "move container to workspace number 4";
				"${modifier}+Shift+5" = "move container to workspace number 5";
				"${modifier}+Shift+6" = "move container to workspace number 6";
				"${modifier}+Shift+7" = "move container to workspace number 7";
				"${modifier}+Shift+8" = "move container to workspace number 8";
				"${modifier}+Shift+9" = "move container to workspace number 9";
				"${modifier}+Shift+0" = "move container to workspace number 10";
				"${modifier}+Left" = "focus left";
				"${modifier}+Down" = "focus down";
				"${modifier}+Up" = "focus up";
				"${modifier}+Right" = "focus right";
				"${modifier}+Shift+Left" = "move left";
				"${modifier}+Shift+Down" = "move down";
				"${modifier}+Shift+Up" = "move up";
				"${modifier}+Shift+Right" = "move right";
				"${modifier}+h" = "splith";
				"${modifier}+v" = "splitv";
				"Control+Print" =         "exec grimshot save area";
				"Control+Shift+Print" =   "exec grimshot copy area";
				"Alt+Print" =             "exec grimshot save window";
				"Alt+Shift+Print" =       "exec grimshot copy window";
				"XF86AudioRaiseVolume" =  "exec pamixer --increase 5";
				"XF86AudioLowerVolume" =  "exec pamixer --decrease 5";
				"XF86AudioMute" =         "exec pamixer --toggle-mute";
				"XF86AudioMicMute" =      "exec pamixer --default-source --toggle-mute";
				"XF86MonBrightnessUp" =   "exec brightnessctl s +20%";
				"XF86MonBrightnessDown" = "exec brightnessctl s 20%-";
				"XF86AudioPlay" =         "exec playerctl play-pause";
				"XF86AudioNext" =         "exec playerctl next";
				"XF86AudioPrev" =         "exec playerctl previous";
			};
		};
	};

	programs.waybar = {
		enable = true;
		systemd.enable = false;
		style = builtins.readFile ./waybar/style.css;
		settings = [
			{
				layer = "top";
				position = "bottom";
				height = 30;
				modules-left = [
					"sway/workspaces"
					"sway/mode"
					#"wlr/taskbar"
				];
				modules-right = [
					"network"
					"pulseaudio"
					"cpu"
					"battery"
					"tray"
					"clock"
				];
				modules = {
					battery = {
						interval = 1;
						states = {
							warning = 30;
							critical = 15;
						};
						# Connected to AC;
						format = " {icon}  "; # Icon: bolt;
						# Not connected to AC;
						format-discharging = "{icon}  ";
						format-icons = [
							"" # Icon: battery-full;
							"" # Icon: battery-three-quarters;
							"" # Icon: battery-half;
							"" # Icon: battery-quarter;
							"" # Icon: battery-empty;
						];
					};

					clock = {
						interval = 1;
						format = "{:%a %e %b %y  %H:%M} ";
						tooltip = false;
					};

					cpu = {
						interval = 5;
						format = "  {load}"; # Icon: microchip;
						states = {
						  warning = 70;
						  critical = 90;
						};
					};

					network = {
						interval = 5;
						format-wifi = "   {essid} "; # Icon: wifi;
						format-ethernet = "  {ifname}: {ipaddr}/{cidr}"; # Icon: ethernet;
						format-disconnected = "⚠  Disconnected";
						tooltip-format = "{ifname}: {ipaddr}/{cidr} {signalStrength}%";
					};

					"sway/mode" = {
						format = "<span style=\"italic\">  {}</span>"; # Icon: expand-arrows-alt;
						tooltip = false;
					};

					"sway/workspaces" = {
						all-outputs = false;
						disable-scroll = false;
						enable-bar-scroll = true;
						disable-scroll-wraparonud = true;
						smooth-scrolling-threshold = 1;
						format = "{name}";
						format-icons = {
							urgent = "";
							focused = "";
							default = "";
						};
					};

					pulseaudio = {
						#scroll-step = 1;
						format = "{icon}  {volume}%";
						format-bluetooth = "{icon}  {volume}%";
						format-muted = "";
						format-icons = {
							headphones = "";
							handsfree = "";
							headset = "";
							phone = "";
							portable = "";
							car = "";
							default = ["" ""];
						};
						on-click = "pavucontrol";
					};

					tray = {
						icon-size = 21;
						spacing = 10;
					};
				};
			}
		];
	};
}
