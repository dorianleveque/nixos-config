{ ... }:

{
  imports = [

    # common system components
    ./bash.nix
    ./boot.nix
    ./env-variables.nix
    ./networking.nix
    ./pipewire.nix
    ./system.nix

    # desktop environnements
    ./desktop-environments/gnome.nix
    ./desktop-environments/hyprland.nix

    # features availables
    ./features/android-webcam.nix
    ./features/firefox.nix
    ./features/flathub.nix
    ./features/git.nix
    ./features/printing.nix
    ./features/steam.nix
  ];
}
