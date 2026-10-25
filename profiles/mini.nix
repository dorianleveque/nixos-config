{ pkgs, ... }:

{
  features = { };

  environment.systemPackages = with pkgs; [
    fastfetch
  ];

  # caches the devShell, avoids re-evaluating it every time
  programs.direnv.enable = true;
}
