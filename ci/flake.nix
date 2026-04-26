{
  inputs.nixos-config.url = "github:dorianleveque/my-nixos-config/main";
  outputs = { nixos-config, ... }: {
    nixosConfigurations = nixos-config.lib.mkSystems {

      mini = {
        profile = "mini";
        configuration-file = ./configuration.nix;
      };

      home = {
        profile = "home";
        configuration-file = ./configuration.nix;
      };

      gaming = {
        profile = "gaming";
        configuration-file = ./configuration.nix;
      };
    };
  };
}
