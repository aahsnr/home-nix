{ inputs, pkgs, config, lib, self,...}:

{
  home = {
    username = "ahsan";
    homeDirectory = "/home/ahsan";
    stateVersion = "24.05";
    extraOutputsToInstall = ["doc" "info" "devdoc"];
  };

  imports = [
    ./foot
    ./git
    ./gtk 
    ./hyprland
    #./mako
    ./mpv
    #./nvim
    #./scripts
    ./gtk
    ./packages.nix
    #./tools
    ./zathura
    ./zsh
    inputs.hyprland.homeManagerModules.default
  ];
}
