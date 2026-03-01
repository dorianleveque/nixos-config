{ config, lib, pkgs, ... }:

{
  services.flatpak.enable = true;

  system.activationScripts.flatpak-flathub.text = ''
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub \
        https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
}
