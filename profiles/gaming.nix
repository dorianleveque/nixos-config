{ pkgs, ... }:

{
  imports = [ ./home.nix ];

  features = {
    steam.enable = true;
  };

  environment.systemPackages = with pkgs; [
    (bottles.override { removeWarningPopup = true; })
    discord
  ];
}
