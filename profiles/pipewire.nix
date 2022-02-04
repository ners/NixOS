{ lib, ... }:

{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    media-session.enable = true;
    pulse.enable = true;
  };
  sound.enable = true;
  hardware.pulseaudio.enable = lib.mkForce false;
}
