{ config, pkgs, ... }:
{
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "always";
    git = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };
}
