{ config, ... }:

{
  # Hide nix documentation shortcut. Useless for non admin users.
  documentation.nixos.enable = false;

  # Configure the NixOS package manager
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
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
  
  system.autoUpgrade = {
    enable = true;
    flake = "github:dorianleveque/my-nixos-config#default";
    operation = "boot";
    flags = [ "--impure" ];
  };
}
