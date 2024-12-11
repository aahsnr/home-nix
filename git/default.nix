{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "aahsnr";
    userEmail = "ahsanur041@proton.me";
    signing = {
      key = "C1CD1A946EAAA7DB";
      #signByDefault = true;
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
