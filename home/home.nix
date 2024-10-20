{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "ahsan";
    homeDirectory = "/home/ahsan";
    stateVersion = "24.05"
  };
  
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = true;
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
