{ config, lib, pkgs, ... }:

{
  programs.hyprland.enable = true;
  
  environment.systemPackages = with pkgs; [
    hyprpaper
    waybar
  ];
}
