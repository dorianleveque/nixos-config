{
  description = "Configuration NixOS commune";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05"; # stable channel
    mybash = {
      url = "github:dorianleveque/mybash";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      mybash,
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      formatter.${system} = pkgs.nixfmt;

      lib.mkSystems = builtins.mapAttrs (
        machine_id: localArgs:
        nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = {
            inherit machine_id mybash localArgs;
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
