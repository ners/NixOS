{ pkgs, ... }:

let
  swaymsg = command: ''${pkgs.sway}/bin/swaymsg "${command}"'';
in
{
  services.kanshi = {
    enable = true;
    profiles = {
      godot_standalone = {
        outputs = [
          {
            criteria = "eDP-1";
            mode = "3840x2400";
            position = "0,0";
          }
        ];
        exec = [
          (swaymsg "workspace 1, move workspace to eDP-1")
        ];
      };
      normandy_home =
        let
          left = "Dell Inc. DELL UP3017 Y7NWN6BU103L";
          right = "Dell Inc. DELL UP3017 Y7NWN6BU117L";
        in
        {
          outputs = [
            {
              criteria = left;
              mode = "2560x1600";
              position = "0,0";
            }
            {
              criteria = right;
              mode = "2560x1600";
              position = "2560,0";
            }
          ];
          exec = [
            (swaymsg "workspace 1, move workspace to '${left}'")
            (swaymsg "workspace 2, move workspace to '${right}'")
          ];
        };
    };
  };
}


