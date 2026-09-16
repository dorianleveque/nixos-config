{ machine_id, localArgs, pkgs, revision, ... }:

{
  # Hide nix documentation shortcut. Useless for non admin users.
  documentation.nixos.enable = false;

  # Configure the NixOS package manager
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Configure the nix garbage collector to clean lastest builds.
  # Useful to avoid system taking to much space like Windows ;)
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 30d";
      
    # Relaunch the garbage collector at system startup 
    # if system was shutdown before its execution. 
    persistent = true;
  };	

  # Improve SSD management
  services.fstrim = {
    enable = true;
    interval = "daily";
  };

  # Auto upgrade
  system.autoUpgrade = {
    enable = true;
    flake = "/etc/nixos#${machine_id}";
    operation = "boot";
  };

  system.configurationRevision = "${revision}-${localArgs.profile}";

  systemd.services = {
    nix-flake-update = {
      description = "Update NixOS flake inputs";
      before = [ "nixos-upgrade.service" ];
      wantedBy = [ "nixos-upgrade.service" ];
      serviceConfig = {
        Type = "oneshot";
        User = "root";
        WorkingDirectory = "/etc/nixos";
        ExecStart = "${pkgs.nix}/bin/nix flake update";
      };
    };

    nixos-upgrade = {
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];

      # Check that nixos servers are available before launching nixos-rebuild
      preStart = ''
        if ! ${pkgs.curl}/bin/curl -fsS --max-time 10 https://nixos.org >/dev/null 2>&1; then
          echo "No Internet connection available to the NixOS servers, aborting (will retry in 30 minutes)."
          exit 1
        fi
      '';

      serviceConfig = {
        Restart = "on-failure";
        RestartSec = "30min";
      };
    };
  };
}
