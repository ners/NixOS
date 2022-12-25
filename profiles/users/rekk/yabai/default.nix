{ ... }:

{
  xdg.configFile."../.yabairc".text = ''
    #!/usr/bin/env sh

    # global settings
    yabai -m config mouse_follows_focus          on
    yabai -m config focus_follows_mouse          autofocus
    yabai -m config window_placement             second_child
    yabai -m config window_topmost               off
    yabai -m config window_shadow                off
    yabai -m config window_opacity               off
    yabai -m config window_border                on
    yabai -m config window_border_width          3
    yabai -m config window_border_radius         9
    yabai -m config active_window_border_color   0xff4c78cc
    yabai -m config normal_window_border_color   0x00000000
    yabai -m config insert_feedback_color        0xffd75f5f
    yabai -m config split_ratio                  0.50
    yabai -m config auto_balance                 off
    yabai -m config mouse_modifier               fn
    yabai -m config mouse_action1                move
    yabai -m config mouse_action2                resize
    yabai -m config mouse_drop_action            swap

    # general space settings
    yabai -m config layout                       bsp
    yabai -m config top_padding                  0
    yabai -m config bottom_padding               0
    yabai -m config left_padding                 0
    yabai -m config right_padding                0
    yabai -m config window_gap                   2

    # Exclude some apps
    yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off

    echo "yabai configuration loaded.."
  '';

# TODO: migrate homebrew yabai instance to yabai service
#  services.yabai = {
#    enable = true;
#    config = {
#      mouse_follows_focus = "on";
#      focus_follows_mouse = "autofocus";
#      window_placement = "second_child";
#      window_topmost = "off";
#      window_shadow = "off";
#      window_opacity = "off";
#      window_opacity_duration = 0.2;
#      active_window_opacity = 1.0;
#      normal_window_opacity = 1.00;
#      window_border = "on";
#      window_border_width = 4;
#      window_border_radius = 2;
#      active_window_border_color = "0xff4c7899";
#      insert_feedback_color = "0xffd75f5f";
#      split_ratio = 0.50;
#      auto_balance = "off";
#      mouse_modifier = "fn";
#      mouse_action1 = "move";
#      mouse_action2 = "resize";
#      mouse_drop_action = "swap";
#      layout = "bsp";
#      top_padding = 0;
#      bottom_padding = 0;
#      left_padding = 0;
#      right_padding = 0;
#      window_gap = 2;
#    };
#
#    extraConfig = ''
#      # Exclude some apps
#      yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off
#
#      echo "yabai configuration loaded.."
#    '';
#  };
#
#  launchd.user.agents.yabai.serviceConfig = {
#    StandardOutPath = "/tmp/yabai.out.log";
#    StandardErrorPath = "/tmp/yabai.err.log";
#  };
}
