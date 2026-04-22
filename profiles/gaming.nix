{ ... }:

{
  imports = [ ./home.nix ];

  features = {
    gamepad.enable = true;
    steam.enable = true;
  };
}
