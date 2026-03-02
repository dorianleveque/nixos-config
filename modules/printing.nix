{ config, pkgs, ... }:

let
  allUsers = builtins.attrNames config.users.users;
  normalUsers = builtins.filter (user: config.users.users.${user}.isNormalUser) allUsers;
in
{
  # Enable CUPS to print documents.
  services = {
    printing = {
      enable = true;
      openFirewall = false;
      startWhenNeeded = true;
      drivers = with pkgs; [
        #brgenml1cupswrapper
        #brgenml1lpr
        #brlaser
        #cnijfilter2
        #epkowa
        #gutenprint
        #gutenprintBin
        #hplip
        #epson-escpr2
        #epson-escpr
        #samsung-unified-linux-driver
        #splix
      ];
    };

    # Enable autodiscovery from network
    avahi = {
      enable = true;
      nssmdns4 = true;     # enables mDNS discovery of network printers
      openFirewall = true; # required to receive mDNS announcements
    };

    # Enable autodiscovery from USB
    ipp-usb.enable = true;

    udev.packages = with pkgs; [
      sane-airscan
      utsushi
    ];
  };

  hardware.sane = {
    enable = true;
    extraBackends = with pkgs; [
      sane-airscan
      epkowa
      utsushi
    ];
    #disabledDefaultBackends = [ "escl" ];
  };

  # add all users to group scanner and lp
  users.groups.scanner.members = normalUsers;
  users.groups.lp.members = normalUsers;
}
