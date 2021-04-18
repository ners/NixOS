{ config, pkgs, ... }:

let
	mozillaTarball = fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz;
	mozillaOverlay = import ( mozillaTarball );
in
{
	nixpkgs.overlays = [
		mozillaOverlay
	];

	environment.systemPackages = with pkgs; [
		# firefox-wayland
		latest.firefox-nightly-bin
	];
}
