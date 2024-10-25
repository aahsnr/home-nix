{ inputs, pkgs, config, packages, self, ...}:

{
  home.packages = with pkgs; [
    brave
    spotify
    unzip
    pymol
    xournalpp
    transmission_4-gtk
    spotify
    gcc
    cmake
    nwg-drawer
    nwg-look
    nwg-hello
    config.wayland.windowManager.hyprland.package
   ];
}
