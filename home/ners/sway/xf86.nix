{ config, pkgs, ... }:

let modifier = config.wayland.windowManager.sway.config.modifier;
in
{
  home.packages = with pkgs; [
    brightnessctl
    pamixer
    playerctl
  ];

  wayland.windowManager.sway.config.keybindings = {
    "XF86AudioRaiseVolume" = "exec pamixer --increase 5";
    "XF86AudioLowerVolume" = "exec pamixer --decrease 5";
    "XF86AudioMute" = "exec pamixer --toggle-mute";
    "XF86AudioMicMute" = "exec pamixer --default-source --toggle-mute";
    "XF86MonBrightnessUp" = "exec brightnessctl s +10%";
    "XF86MonBrightnessDown" = "exec brightnessctl s 10%-";
    "XF86AudioPlay" = "exec playerctl play-pause";
    "XF86AudioNext" = "exec playerctl next";
    "XF86AudioPrev" = "exec playerctl previous";
  };
}
