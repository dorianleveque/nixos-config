{
  inputs.nixos-config.url = "github:dorianleveque/my-nixos-config/main";
  outputs = { nixos-config, ... }: {
    nixosConfigurations.default = nixos-config.lib.mkSystem {
      profile = "default";
      hardware = ./hardware-configuration.nix;
      local = ./configuration.nix;
    };
  };
}
