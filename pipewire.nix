{ config, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		pipewire
		qjackctl
	];
	
	services.pipewire = {
		enable = true;
		media-session.enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
	};
	
	sound.enable = true;
	hardware.pulseaudio.enable = false;
}
