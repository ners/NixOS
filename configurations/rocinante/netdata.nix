{ pkgs, ... }:

{
  services.netdata = {
    enable = true;
    package = pkgs.unstable.netdata;

    config = {
      global = {
        # reduce memory to 32 MB
        #"page cache size" = 32;

        # update interval
        "update every" = 15;
      };
      ml = {
        # enable machine learning
        enabled = "yes";
      };
    };
  };
}
