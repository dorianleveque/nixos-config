{ config, pkgs, ... }:

{
  boot = {
  
    # Hide verbose logs at startup
    consoleLogLevel = 3;
    kernelParams = [ "quiet" "splash" "boot.shell_on_fail" "udev.log_priority=3" "rd.systemd.show_status=auto" ];
    
    # Force to use the last Linux kernel
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      systemd-boot.enable = true;

      # Limit the number of generations to prevent the EFI partition from becoming full,
      # which could prevent automatic updates from being applied.
      systemd-boot.configurationLimit = 5;

      efi.canTouchEfiVariables = true;

      # Hide the OS choice for bootloaders.
      # It's still possible to open the bootloader list by pressing any key
      # It will just not appear on screen unless a key is pressed
      timeout = 0;
    };
    
    # Play a loading screen at startup
    plymouth.enable = true;
    
    # Fix the animation resolution
    initrd.kernelModules = [ "amdgpu" ];
    kernelModules = [ "amdgpu" ];
  };
  
  hardware.graphics.enable = true;
}
