{ config, pkgs, ... }: {
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
      pamixer
      playerctl
      sway-contrib.grimshot
      swayidle
      swaylock
      waybar
      wlsunset
      wdisplays
      wl-clipboard
      wofi
      xwayland
      (import ./packages/screenlock)
    ];
  };
}
