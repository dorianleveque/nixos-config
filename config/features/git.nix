{ config, lib, ... }:

{
  options.features.git.enable = lib.mkEnableOption "Git";

  config = lib.mkIf config.features.git.enable {
    programs.git = {
      enable = true;
      config = {
        core.excludesfile = builtins.toFile "gitignore" ''
          node_modules
          build
          dist
          .DS_Store
        '';
        init = {
          defaultBranch = "main";
        };
      };
    };
  };
}
