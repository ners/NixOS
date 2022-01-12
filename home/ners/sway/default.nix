{ config, pkgs, lib, ... }:

{
  imports = [
    ./albert.nix
    ./foot.nix
    ./kanshi.nix
    ./mako.nix
    ./waybar.nix
    ./xf86.nix
  ];
  home.packages = with pkgs; [
    (callPackage ./inter-nerd { })
    (callPackage ./screenlock { })
    blueman
    gnome.networkmanagerapplet
    pavucontrol
    polkit_gnome
    swayidle
    swaylock
    vanilla-dmz
    wdisplays
    wl-clipboard
    xwayland
  ];

  services.wlsunset = {
    enable = true;
    latitude = "47.3769";
    longitude = "8.5417";
  };
  services.gnome-keyring.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    systemdIntegration = true;
    wrapperFeatures.gtk = true;
    config = rec {
      modifier = "Mod4";
      input = {
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_variant = "dvorak";
          repeat_rate = "50";
          repeat_delay = "150";
          xkb_options = "caps:escape,compose:ralt";
        };
        "type:mouse" = {
          accel_profile = "flat";
          pointer_accel = "1";
        };
        "type:touchpad" = {
          tap = "enabled";
          pointer_accel = "0.75";
        };
      };
      output = { "*" = { bg = "~/.background fill"; }; };
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
          command = "blueman-applet";
          always = true;
        }
        {
          command = "nm-applet --indicator";
          always = true;
        }
        {
          command = "systemctl --user restart kanshi";
          always = true;
        }
        {
          command =
            "export $(${pkgs.gnome.gnome-keyring}/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)";
          always = true;
        }
        {
          command =
            "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          always = false;
        }
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
      ];
      keybindings = {
        "${modifier}+Shift+r" = "reload";
        "${modifier}+Shift+apostrophe" = "kill";
        "${modifier}+l" = "screenlock";
        "${modifier}+Shift+f" = "fullscreen";
        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";
        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+Shift+Escape" =
          "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
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
        "${modifier}+r" = "mode resize";
      };
    };
  };

  xdg.configFile."xdg-desktop-portal-wlr/config".text =
    lib.generators.toINI { } {
      screencast = {
        output_name = "";
        max_fps = "30";
        chooser_cmd = "slurp -f %o -or";
        chooser_type = "simple";
      };
    };
}
