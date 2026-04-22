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
    lib.mkSystem = { profile ? "home", hardware, local }:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit mybash profile;
          revision = self.shortRev or "dirty";
        };
        modules = [
          hardware
          local
          ./config/common.nix
          ./profiles/${profile}.nix
        ];
      };
  };
}
