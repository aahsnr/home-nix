{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "zielOS";
    userEmail = "ahsanur041@gmail.com";
    #signing = {
    #  key = "056CFD15A9F99B0E";
    #  signByDefault = true;
  #  };
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
