{ pkgs, ... }:

{
  features = { };

  environment.systemPackages = with pkgs; [
    fastfetch

    # Expose the application path to the system in order to resolve copy/paste
    # issues between Wayland and applications.
    wl-clipboard
  ];

  # direnv + nix-direnv : loads the devShell automatically and caches it
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
