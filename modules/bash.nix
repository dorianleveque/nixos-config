{ config, mybash, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zip
  ];

  programs.bat.enable = true;
  programs.bash = {
    enable = true;
    interactiveShellInit = builtins.readFile "${mybash}/.bashrc";
        
    # Customize the look
    promptInit = builtins.readFile "${mybash}/.bash_prompt";
  };
}
