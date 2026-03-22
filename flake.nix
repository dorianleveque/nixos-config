{
  description = "Configuration NixOS commune";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11"; # stable channel
    local = {
      url = "path:/etc/nixos";
      flake = false;  # c'est un répertoire, pas un flake
    };
  };

  outputs = { self, nixpkgs, local }: {
    nixosConfigurations = {
    
      # Profil par défaut — parents, cousines
      # nixos-install --flake github:toi/nixos-config#common
      default = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          "${local}/hardware-configuration.nix"
          "${local}/configuration.nix"
          ./modules/default.nix
        ];
      };

      # Profil gaming — ta machine de jeu
      # nixos-install --flake github:toi/nixos-config#gaming
      gaming = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          "${local}/hardware-configuration.nix"
          "${local}/configuration.nix"
          ./modules/default.nix
      #    ./modules/gaming.nix
        ];
      };

    };
  };
}
