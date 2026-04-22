{ ... }:

{
  imports = [

    # standard system configuration
    ./bash.nix
    ./boot.nix
    ./env-variables.nix
    ./networking.nix
    ./pipewire.nix
    ./system.nix

    # desktop environnements
    ./desktop-environments/gnome.nix
    ./desktop-environments/hyprland.nix

    # optional features 
    ./features/android-webcam.nix
    ./features/firefox.nix
    ./features/flathub.nix
    ./features/git.nix
    ./features/printing.nix
    ./features/steam.nix
  ];
}
