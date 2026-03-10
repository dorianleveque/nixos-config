{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

  outputs = { nixpkgs, ... }: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        { nix.settings.experimental-features = ["nix-command" "flakes"]; }
        ./modules/default.nix
        /etc/nixos/hardware-configuration.nix
        /etc/nixos/local.nix
      ];
    };
  };
}
