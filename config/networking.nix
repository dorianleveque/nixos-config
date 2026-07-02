{ config, lib, hostname, ... }:

let
  isDhcpManaged = hostname == "default";
in
{
  networking = {
    # Enable networking
    networkmanager.enable = true;

    # Define the hostname
    hostName = lib.mkIf (!isDhcpManaged) hostname;

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    useDHCP = lib.mkDefault true;

    # Prevents the modification of the hostname via the UI (e.g GNOME Settings)
    # by a non-root user, only when the hostname is manages by the DHCP server.
    security.polkit.extraConfig = lib.mkIf isDhcpManaged ''
      polkit.addRule(function(action, subject) {
        switch(action.id) {
          case "org.freedesktop.hostname1.set-static-hostname":
          case "org.freedesktop.hostname1.set-hostname":
          case "org.freedesktop.hostname1.set-pretty-hostname":
            return subject.user === "root" ? polkit.Result.YES : polkit.Result.NO
        }
      });
    '';
  };
}
