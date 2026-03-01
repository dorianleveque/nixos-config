{ ... }:

{
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
}
