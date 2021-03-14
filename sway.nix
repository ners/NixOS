{ config, pkgs, ... }:
{
	services.xserver.displayManager.defaultSession = "sway";
	programs.sway = {
		enable = true;
		wrapperFeatures.gtk = true;
		extraPackages = with pkgs; [
			alacritty
			brightnessctl
			grim
			kanshi
			mako
			playerctl
			python3
			python3Packages.i3ipc
			python3Packages.pillow
			sway-contrib.grimshot
			swayidle
			swaylock
			unstable.waybar
			unstable.wlsunset
			wdisplays
			wl-clipboard
			wofi
			xwayland
			(import ./packages/screenlock)
		];
	};
	location.provider = "geoclue2";
	services.geoclue2.enable = true;
	environment.etc = {
		"sway/config".source = ./dotfiles/sway/config;
		"sway/screenlock".source = ./dotfiles/sway/screenlock;
		"sway/conf".source = ./dotfiles/sway/conf;
		"xdg/waybar".source = ./dotfiles/waybar;
	};
}
