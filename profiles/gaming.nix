{ ... }:

{
  imports = [ ./home.nix ];

  features = {
    steam.enable = true;
  };
}
