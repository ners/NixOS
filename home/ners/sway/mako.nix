{ ... }:

{
  programs.mako = {
    enable = true;
    defaultTimeout = 3000;
    font = "Monospace 11";
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
}
