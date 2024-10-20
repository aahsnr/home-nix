{ inputs, pkgs, config, lib, self,...}:

{
  home = {
    username = "ahsan";
    homeDirectory = "/home/ahsan";
    stateVersion = "23.11";
    extraOutputsToInstall = ["doc" "info" "devdoc"];
  };

  imports = [
    ./ags_setup.nix
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
    ./shell
    #./tools
    ./zathura
    #./zsh
    inputs.hyprland.homeManagerModules.default
  ];
}
