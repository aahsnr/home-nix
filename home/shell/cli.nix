{ config, pkgs, ... }:

{
  programs = {
    eza.enable = true;
    gpg.enable = true;
    man.enable = true;
    ssh.enable = false;

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
