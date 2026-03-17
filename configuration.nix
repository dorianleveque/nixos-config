# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, modulesPath, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #./local.nix
      ./modules/default.nix
    ];

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "fr_FR.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };
  };

  services = {

    # Fix keyboard layout for gdm.
    xserver.xkb = {
      layout = "fr";
      variant = "";
    };
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dorian = {
    isNormalUser = true;
    description = "dorian";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # Gamer softwares
      (bottles.override { removeWarningPopup = true; })
      discord

      # Dev softwares
      dconf-editor #(maybe with flatpak)
      gnome-builder
      micro
      nodejs
      python3Minimal
      #vscode
    ];
  };
 
  environment = {
    
    # not necessary, I think
    sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
      gst-plugins-base
      gst-plugins-good
      gst-plugins-bad
      gst-plugins-ugly
      gst-libav
    ]);
    
    systemPackages = with pkgs; [
      nautilus-python # TODO move in gnome.nix when patch will be ready
      
      # Core softwares
      fastfetch
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
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
