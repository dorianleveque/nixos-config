{ config, lib, pkgs, ... }:

{
  options.features.steam.enable = lib.mkEnableOption "Steam";

  config = lib.mkIf config.features.steam.enable {
  
    programs.steam = {
      enable = true;
      
      # Open ports in the firewall for Source Dedicated Server
      dedicatedServer.openFirewall = true; 
      
      # Open ports in the firewall for Steam Remote Play
      remotePlay.openFirewall = true; 
      
      # Open ports in the firewall for Steam Local Network Game Transfers
      localNetworkGameTransfers.openFirewall = true; 
    };
  };
}
