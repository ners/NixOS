{ config, lib, pkgs, options, ... }:

with lib;

{
  boot = {
    # Use the latest kernel!
    kernelPackages = pkgs.linuxPackages_latest;

    # This will install a pre-release of zfs. Required because the ZFS module may not yet
    # support the latest kernel version and may report as broken.
    zfs.enableUnstable = true;

    loader = {
      # The number of seconds for user intervention before the default boot option is selected.
      timeout = mkDefault 3;
      efi.canTouchEfiVariables = true;
      grub.enable = false;
      systemd-boot = {
        enable = true;
        # The resolution of the console. A higher resolution displays more entries.
        consoleMode = "max";
      };
    };

    initrd = {
      availableKernelModules = [ "aesni_intel" "cryptd" ];
      luks.devices = mkDefault {
        cryptroot = {
          device = mkDefault "/dev/disk/by-partlabel/LUKS";
          preLVM = mkForce true;
          allowDiscards = mkForce true;
        };
      };
      # Use systemd for PID 1.
      systemd.enable = true;
    };

    # Plymouth presents a graphic animation (also known as a bootsplash) while the system boots.
    # It provides eye-candy and a more professional presentation for scenarios where the default
    # high-information text output might be undesirable.
    # It also handles boot prompts, such as entering disk encryption passwords.
    plymouth.enable = true;
  };

  console = {
    # Enable setting virtual console options as early as possible (in initrd).
    earlySetup = true;
    # Provide a hi-dpi console font.
    packages = options.console.packages.default ++ [ pkgs.terminus_font ];
  };
}
