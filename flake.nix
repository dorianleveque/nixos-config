{
  description = "Configuration NixOS commune";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11"; # stable channel
    local = {
      url = "path:/etc/nixos";
      flake = false;
    };
    mybash = {
      url = "github:dorianleveque/mybash";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, local, mybash }: 
  let
    mkSystem = extraModules: nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit mybash; };
      modules = [
        "${local}/hardware-configuration.nix"
        "${local}/configuration.nix"
        ./modules/default.nix
      ] ++ extraModules;
    };
  in {
    nixosConfigurations = {
    
      # Profil par défaut — parents, cousines
      # nixos-install --flake github:toi/nixos-config#common
      default = mkSystem [];

      # Profil gaming — ta machine de jeu
      # nixos-install --flake github:toi/nixos-config#gaming
      gaming = mkSystem [
      # ./modules/gaming.nix
      ];
    };
  };
}
