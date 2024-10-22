{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "zielOS";
    userEmail = "ahsanur041@gmail.com";
    signing = {
      key = "C4F48AB2F59DC91C";
      signByDefault = true;
    };
    
    delta = {
      enable = true;
      options.dark = true;
    };
    ignores = [
      ".cache/"
      ".DS_Store"
      ".idea/"
      "*.swp"
      "*.elc"
      "auto-save-list"
      ".direnv/"
      "node_modules"
      "result"
      "result-*"
    ];
  };
}
