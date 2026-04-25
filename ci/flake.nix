{
  inputs.nixos-config.url = "github:dorianleveque/my-nixos-config/main";
  outputs = { nixos-config, ... }: {
    nixosConfigurations = {

      mini = nixos-config.lib.mkSystem {
        profile = "mini";
        hardware = ./hardware-configuration.nix;
        local = ./configuration.nix;
      };

      default = nixos-config.lib.mkSystem {
        profile = "home";
        hardware = ./hardware-configuration.nix;
        local = ./configuration.nix;
      };

      gaming = nixos-config.lib.mkSystem {
        profile = "gaming";
        hardware = ./hardware-configuration.nix;
        local = ./configuration.nix;
      };
    };
  };
}
