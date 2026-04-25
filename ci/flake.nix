{
  inputs.nixos-config.url = "github:dorianleveque/my-nixos-config/main";
  outputs = { nixos-config, ... }: {
    nixosConfigurations = {

      mini = nixos-config.lib.mkSystem {
        profile = "mini";
        local-configuration = ./configuration.nix;
      };

      default = nixos-config.lib.mkSystem {
        profile = "home";
        local-configuration = ./configuration.nix;
      };

      gaming = nixos-config.lib.mkSystem {
        profile = "gaming";
        local-configuration = ./configuration.nix;
      };
    };
  };
}
