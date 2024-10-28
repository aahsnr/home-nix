{ config, pkgs, ... }:
{
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "auto";
    git = true;
    extraOptions = [
      "--group-directories-first"
      "--tree"
      "--all"
    ];
  };
}