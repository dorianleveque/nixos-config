{ pkgs, ... }:

{
  features = { };

  environment.systemPackages = with pkgs; [
    fastfetch
  ];

  # direnv + nix-direnv : loads the devShell automatically and caches it
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
