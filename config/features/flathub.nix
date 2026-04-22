{ config, lib, pkgs, ... }:

{
  options.features.flatpak.enable = lib.mkEnableOption "Flatpak";

  config = lib.mkIf config.features.flatpak.enable {
    services.flatpak.enable = true;

    system.activationScripts.flatpak-flathub.text = ''
        ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub \
          https://dl.flathub.org/repo/flathub.flatpakrepo
      '';
  };
}
