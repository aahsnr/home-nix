{ inputs, pkgs, config, packages, self, ...}:

{
  home.packages = with pkgs; [
    bitwarden-desktop
    onlyoffice-bin
    brave
    spotify
    unzip
    pymol
    xournalpp
    deluge-gtk
    spotify
    gcc
    cmake
    nwg-drawer
    nwg-look
    nwg-hello
    inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
   ];
}
