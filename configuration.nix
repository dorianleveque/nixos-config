# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  networking = {
    # hostName = "Winterfell"; # Define your hostname.
    
    # Enable networking
    networkmanager.enable = true;
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

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
  
    flatpak.enable = true;
    
    # Enable the X11 windowing system.
    xserver.enable = true;
    xserver.excludePackages = [ pkgs.xterm ]; # remove xterminal
    xserver.videoDriver = "amdgpu";
  
    # Enable the GNOME Desktop Environment.
    # displayManager.sddm.enable = true;
    xserver.displayManager.gdm.enable = true;
    xserver.desktopManager.gnome.enable = true;
    xserver.desktopManager.xterm.enable = false; # remove xterminal

    # Configure keymap in X11
    xserver.xkb = {
      layout = "fr";
      variant = "";
    };
    
    # Enable touchpad support (enabled default in most desktopManager).
    # xserver.libinput.enable = true;
    
    # Enable CUPS to print documents.
    printing.enable = true;
    
    # Enable sound with pipewire.
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
  };

  # Configure console keymap
  console.keyMap = "fr";

  security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dorian = {
    isNormalUser = true;
    description = "dorian";
    extraGroups = [ "networkmanager" "wheel" ];
    #packages = with pkgs; [
    #  dconf-editor
    #  git
    #  micro
    #  vscode
    #  wget
    #  zip
    #];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System programs
  programs = {
    firefox.enable = true;
    hyprland.enable = true;
    
    kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };
    
    steam = {
      enable = false;
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
    
  };
  
  environment = {
    
    gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-system-monitor
    ];
    
    sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
      gst-plugins-base
      gst-plugins-good
      gst-plugins-bad
      gst-plugins-ugly
      gst-libav
    ]);
    
    systemPackages = with pkgs; [
      adw-gtk3
      apple-cursor
      desktop-file-utils
      fastfetch
      gnome-photos
      gnomeExtensions.arcmenu
      gnomeExtensions.blur-my-shell
      gnomeExtensions.caffeine
      gnomeExtensions.daily-bing-wallpaper
      gnomeExtensions.dash-to-panel
      gnomeExtensions.gsconnect
      gnomeExtensions.gtk4-desktop-icons-ng-ding
      gnomeExtensions.night-theme-switcher
      gnomeExtensions.removable-drive-menu
      gnomeExtensions.remove-world-clocks
      home-manager
      mission-center
      nautilus-python
      onlyoffice-desktopeditors
      pinta
      signal-desktop
      teams-for-linux
      vlc
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
  system.autoUpgrade.enable = true;
  nix.settings.auto-optimise-store = true;
  documentation.nixos.enable = false;
}
