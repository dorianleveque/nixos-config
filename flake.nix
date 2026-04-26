{
  description = "Configuration NixOS commune";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11"; # stable channel
    mybash = {
      url = "github:dorianleveque/mybash";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, mybash }: {
    lib.mkSystems = builtins.mapAttrs (hostname: localArgs:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit mybash hostname localArgs;
          revision = self.shortRev or "dirty";
        };
        modules = [
          localArgs.configuration-file
          ./config/common.nix
          ./profiles/${localArgs.profile or "home"}.nix
        ];
      }
    );
  };
}
