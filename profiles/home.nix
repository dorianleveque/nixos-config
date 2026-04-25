{ pkgs, ... }:

{
  imports = [ ./mini.nix ];

  features = {
    firefox.enable = true;
    flatpak.enable = true;
    git.enable = true;
    printing.enable = true;
    virtualAndroidWebcam.enable = true;
  };

  environment.systemPackages = with pkgs; [
    fragments
    gnome-secrets
    onlyoffice-desktopeditors
    parabolic
    pinta  # need to be replace, not user friendly
    shortwave
    signal-desktop
    tagger
    thunderbird
    upscaler
  ];
}
