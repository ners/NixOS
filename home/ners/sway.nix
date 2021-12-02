{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    (imagemagick.overrideAttrs (_: { buildInputs = [ pkgs.pango ]; }))
    (import ../../packages/inter-nerd)
    (import ../../packages/screenlock)
    alacritty
    albert
    blueman
    brightnessctl
    gnome3.networkmanagerapplet
    grim
    pamixer
    pavucontrol
    playerctl
    sway-contrib.grimshot
    swayidle
    swaylock
    vanilla-dmz
    waybar
    wdisplays
    wl-clipboard
    xwayland
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      background_opacity = 0.85;
      font = {
        normal.family = "Cousine Nerd Font";
        size = 11;
        antialias = true;
        autohint = true;
      };
      window = {
        padding = {
          x = 10;
          y = 5;
        };
      };
    };
  };
  programs.mako = {
    enable = true;
    defaultTimeout = 3000;
    font = "Cousine 11";
    extraConfig = ''
      background-color=#181818
      text-color=#d8d8d8
      border-color=#7cafc2

      [urgency=low]
      background-color=#181818
      text-color=#f7ca88
      border-color=#7cafc2

      [urgency=high]
      background-color=#181818
      text-color=#ab4642
      border-color=#7cafc2
      ignoreTimout=true
    '';
  };

  services.kanshi = {
    enable = true;
    profiles = {
      home = {
        outputs = [
          {
            criteria = "Dell Inc. DELL UP3017 Y7NWN6BU103L";
            mode = "2560x1600";
            position = "0,0";
          }
          {
            criteria = "Dell Inc. DELL UP3017 Y7NWN6BU117L";
            mode = "2560x1600";
            position = "2560,0";
          }
        ];
        exec = [
          ''
            swaymsg "workspace 1, move workspace to 'Dell Inc. DELL UP3017 Y7NWN6BU103L'"''
          ''
            swaymsg "workspace 2, move workspace to 'Dell Inc. DELL UP3017 Y7NWN6BU117L'"''
        ];
      };
    };
  };
  services.wlsunset = {
    enable = true;
    latitude = "47.3769";
    longitude = "8.5417";
  };
  services.gnome-keyring.enable = true;

  xdg.configFile."albert/albert.conf".text = lib.generators.toINI { } {
    General = { showTray = true; };
    "org.albert.extension.applications" = {
      enabled = true;
      fuzzy = false;
      use_generic_name = true;
      use_keywords = true;
    };
    "org.albert.extension.python" = {
      enabled = true;
      enabled_modules =
        "datetime, google_translate, pomodoro, vpn, wikipedia, youtube, unicode_emoji";
    };
    "org.albert.frontend.widgetboxmodel" = {
      alwaysOnTop = true;
      clearOnHide = false;
      displayIcons = true;
      displayScrollbar = false;
      displayShadow = true;
      hideOnClose = false;
      hideOnFocusLoss = true;
      itemCount = 5;
      showCentered = true;
      theme = "Numix Rounded";
    };
    "org.albert.extension.calculator".enabled = true;
    "org.albert.extension.ssh".enabled = true;
  };

  wayland.windowManager.sway = {
    enable = true;
    systemdIntegration = true;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "swaymsg exec -- albert show";
      bars = [{ command = "waybar"; }];
      input = {
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_variant = "dvorak";
          repeat_rate = "50";
          repeat_delay = "150";
          xkb_options = "caps:escape";
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
          command = "albert";
          always = true;
        }
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
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+space" = "exec ${menu}";
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
        "Control+Print" = "exec grimshot save area";
        "Control+Shift+Print" = "exec grimshot copy area";
        "Alt+Print" = "exec grimshot save window";
        "Alt+Shift+Print" = "exec grimshot copy window";
        "XF86AudioRaiseVolume" = "exec pamixer --increase 5";
        "XF86AudioLowerVolume" = "exec pamixer --decrease 5";
        "XF86AudioMute" = "exec pamixer --toggle-mute";
        "XF86AudioMicMute" = "exec pamixer --default-source --toggle-mute";
        "XF86MonBrightnessUp" = "exec brightnessctl s +20%";
        "XF86MonBrightnessDown" = "exec brightnessctl s 20%-";
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";
      };
    };
  };

  programs.waybar = {
    enable = true;
    systemd.enable = false;
    style = builtins.readFile ./waybar/style.css;
    settings = [{
      layer = "top";
      position = "bottom";
      height = 30;
      modules-left = [
        "sway/workspaces"
        "sway/mode"
        #"wlr/taskbar"
      ];
      modules-right = [ "network" "pulseaudio" "cpu" "battery" "tray" "clock" ];
      modules = {
        battery = rec {
          interval = 1;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}";
          format-plugged = "" + format;
          format-charging = format-plugged;
          format-icons = [ "" "" "" "" "" "" "" "" "" "" ];
        };

        clock = {
          interval = 1;
          format = "{:%a %e %b %y  %H:%M} ";
          tooltip = false;
        };

        cpu = {
          interval = 5;
          format = " {load}"; # Icon: microchip;
          states = {
            warning = 70;
            critical = 90;
          };
        };

        network = {
          interval = 5;
          format-wifi = "直  {essid} "; # Icon: wifi;
          format-ethernet = "  {ifname}: {ipaddr}/{cidr}"; # Icon: ethernet;
          format-disconnected = "睊  Disconnected";
          tooltip-format = "{ifname}: {ipaddr}/{cidr} {signalStrength}%";
        };

        "sway/mode" = {
          format =
            ''<span style="italic"> {}</span>''; # Icon: expand-arrows-alt;
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
          format-bluetooth = " {icon}  {volume}% ";
          format-muted = "ﱝ";
          format-icons = rec {
            headphones = "";
            handsfree = headphones;
            headset = headphones;
            phone = "";
            portable = "";
            car = "";
            default = [ "奄" "奔" "墳" ];
          };
          on-click = "pavucontrol";
        };

        tray = {
          icon-size = 21;
          spacing = 10;
        };
      };
    }];
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
