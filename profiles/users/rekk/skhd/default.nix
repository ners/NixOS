{ pkgs, lib, ... }:

let
  yabai = "${pkgs.yabai}/bin/yabai";
in
lib.mkIf pkgs.parsedSystem.isDarwin {
  xdg.configFile."../.skhdrc".text = ''
    # focus window
    cmd - left  : ${yabai} -m window --focus west || ${yabai} -m display --focus west
    cmd - right : ${yabai} -m window --focus east || ${yabai} -m display --focus east
    cmd - down  : ${yabai} -m window --focus south || ${yabai} -m display --focus south
    cmd - up    : ${yabai} -m window --focus north || ${yabai} -m display --focus north

    # move managed window
    shift + cmd - left    : ${yabai} -m window --warp west || $(${yabai} -m window --display west; ${yabai} -m display --focus west)
    shift + cmd - right   : ${yabai} -m window --warp east || $(${yabai} -m window --display east; ${yabai} -m display --focus east)
    shift + cmd - down    : ${yabai} -m window --warp south || $(${yabai} -m window --display south; ${yabai} -m display --focus south)
    shift + cmd - up      : ${yabai} -m window --warp north || $(${yabai} -m window --display north; ${yabai} -m display --focus north)

    # resize window
    ctrl + alt - left      : ${yabai} -m window --resize right:-100:0 || ${yabai} -m window --resize left:-100:0
    ctrl + alt - right     : ${yabai} -m window --resize right:100:0 || ${yabai} -m window --resize left:100:0
    ctrl + alt - up        : ${yabai} -m window --resize bottom:0:-100 || ${yabai} -m window --resize top:0:-100
    ctrl + alt - down      : ${yabai} -m window --resize bottom:0:100 || ${yabai} -m window --resize top:0:100

    # flip split orientation
    shift + cmd - space : ${yabai} -m window --toggle split

    # toggle float
    alt - t : ${yabai} -m window --toggle float;\
              ${yabai} -m window --grid 4:4:1:1:2:2
  '';

  # TODO: migrate homebrew skhd instance to skhd service
  #  services.skhd = {
  #    enable = true;
  #    skhdConfig = ''
  #      # focus window
  #      cmd - left  : yabai -m window --focus west || yabai -m display --focus west
  #      cmd - right : yabai -m window --focus east || yabai -m display --focus east
  #      cmd - down  : yabai -m window --focus south || yabai -m display --focus south
  #      cmd - up    : yabai -m window --focus north || yabai -m display --focus north
  #
  #      # move managed window
  #      shift + cmd - left    : yabai -m window --warp west || $(yabai -m window --display west; yabai -m display --focus west)
  #      shift + cmd - right   : yabai -m window --warp east || $(yabai -m window --display east; yabai -m display --focus east)
  #      shift + cmd - down    : yabai -m window --warp south || $(yabai -m window --display south; yabai -m display --focus south)
  #      shift + cmd - up      : yabai -m window --warp north || $(yabai -m window --display north; yabai -m display --focus north)
  #
  #      # resize window
  #      ctrl + alt - left      : yabai -m window --resize right:-100:0 || yabai -m window --resize left:-100:0
  #      ctrl + alt - right     : yabai -m window --resize right:100:0 || yabai -m window --resize left:100:0
  #      ctrl + alt - up        : yabai -m window --resize bottom:0:-100 || yabai -m window --resize top:0:-100
  #      ctrl + alt - down      : yabai -m window --resize bottom:0:100 || yabai -m window --resize top:0:100
  #
  #      # flip split orientation
  #      shift + cmd - space : yabai -m window --toggle split
  #
  #      # toggle float
  #      alt - t : yabai -m window --toggle float;\
  #                yabai -m window --grid 4:4:1:1:2:2
  #    '';
  #  };
  #
  #  launchd.user.agents.skhd.serviceConfig = {
  #    StandardOutPath = "/tmp/skhd.out.log";
  #    StandardErrorPath = "/tmp/skhd.err.log";
  #  };
}
