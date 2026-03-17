{ config, ... }:

{
  # Hide nix documentation shortcut. Useless for non admin users.
  documentation.nixos.enable = false;


  # Configure the NixOS package manager
  nix.settings = {
    auto-optimise-store = true;
    #experimental-features = [ "nix-command" "flakes" ];
  };
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Configure the nix garbage collector to clean lastest builds.
  # Useful to avoid system taking to much space like Windows ;)
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
      
    # Relaunch the garbage collector at system startup 
    # if system was shutdown before its execution. 
    persistent = true;
  };	


  # Improve SSD management
  services.fstrim = {
    enable = true;
    interval = "daily";
  };
  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
  system.autoUpgrade.enable = true;

  time.hardwareClockInLocalTime = true;
}
