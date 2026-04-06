{
  description = "Configuration NixOS commune";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11"; # stable channel
    mybash = {
      url = "github:dorianleveque/mybash";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, mybash }: 
  let  

    default_config = {
      profile = "default";
      channel = "main";
    };

    # Mix the configuration /etc/nixos/config.json with the default.
    cfg = default_config // (
      if builtins.pathExists /etc/nixos/config.json
      then builtins.fromJSON (builtins.readFile /etc/nixos/config.json)
      else {}
    );
    
    mkSystem = extraModules: nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit cfg mybash;
        revision = self.shortRev or "dirty";
      };
      modules = [
        /etc/nixos/hardware-configuration.nix
        /etc/nixos/configuration.nix
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
