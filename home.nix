{ inputs, pkgs, config, lib, self, ...}:

{
  home = {
    username = "ahsan";
    homeDirectory = "/home/ahsan";
    stateVersion = "24.05";
    extraOutputsToInstall = ["doc" "info" "devdoc"];
  };

  imports = [
    ./bat
    ./foot
    ./fonts
    ./git
    ./gtk 
    #./hyprland
    ./mpv
    ./gtk
    ./packages.nix
    ./zathura
    ./zsh
    inputs.hyprland.homeManagerModules.default
  ];
}
