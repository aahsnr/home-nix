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
    config.wayland.windowManager.hyprland.package
    pyprland
   ];
}
