{ pkgs, ... }:

{
  features = { };

  environment.systemPackages = with pkgs; [
    fastfetch
  ];
}
