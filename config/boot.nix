{ config, pkgs, ... }:

{
  boot = {
  
    # Hide verbose logs at startup
    consoleLogLevel = 3;
    kernelParams = [ "quiet" "splash" "boot.shell_on_fail" "udev.log_priority=3" "rd.systemd.show_status=auto" ];
    
    # Force to use the last Linux kernel
    kernelPackages = pkgs.linuxPackages_latest;
    
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;
    
    # Play a loading screen at startup
    plymouth.enable = true;
    
    # Fix the animation resolution
    initrd.kernelModules = [ "amdgpu" ];
    kernelModules = [ "amdgpu" ];
  };
  
  hardware.graphics.enable = true;
}
