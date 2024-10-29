{ inputs, pkgs, config, packages, self, ...}:

{
  home.packages = with pkgs; [
    bitwarden-desktop
    onlyoffice-bin
    vivaldi
    vivaldi-ffmpeg-codecs
    google-chrome
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
    sbctl
    zotero
   ];
}
