{ inputs, pkgs, config, packages, self, rust-overlay, ...}:

{
  home.packages = with pkgs; [
    cachix
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
    nix-prefetch-git
    nix-prefetch-github
    nwg-drawer
    nwg-look
    nwg-hello
    sbctl
    zotero
    #rust-bin.stable.latest.minimal 
  ];
}
