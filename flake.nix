{
  description = "Configuration NixOS commune";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11"; # stable channel
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
    
      # Profil par défaut — parents, cousines
      # nixos-install --flake github:toi/nixos-config#common
      default = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          /etc/nixos/hardware-configuration.nix
          ./modules/default.nix
        ];
      };

      # Profil gaming — ta machine de jeu
      # nixos-install --flake github:toi/nixos-config#gaming
      #gaming = nixpkgs.lib.nixosSystem {
      #  system = "x86_64-linux";
      #  modules = [
      #    /etc/nixos/hardware-configuration.nix
      #    ./modules/default.nix
      #    ./modules/gaming.nix
      #  ];
      #};

    };
  };
}
