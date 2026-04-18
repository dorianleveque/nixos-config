{ config, pkgs, revision, ... }:

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

  # Auto upgrade
  system.autoUpgrade = {
    enable = true;
    flake = "/etc/nixos";
    operation = "boot";
    flags = [ "--refresh" ];
  };

  system.configurationRevision = "${revision}-${cfg.channel}-${cfg.profile}";

  systemd.services.nixos-upgrade = {
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig.ExecStartPre = "${pkgs.coreutils}/bin/sleep 30";
  };
}
