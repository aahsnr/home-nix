{ inputs, pkgs, config, self, ...}:

{
  home.packages = with pkgs; [
    cachix
    bitwarden-desktop
    onlyoffice-bin
    vivaldi
    vivaldi-ffmpeg-codecs
    google-chrome
    spotify
    gcc14
    cmake
    python312Packages.python
    unzip
    pymol
    xournalpp
    deluge-gtk
    spotify
    nwg-drawer
    nwg-look
    nwg-hello
    sbctl
    zotero
    nix-prefetch-git
    nix-prefetch-github
    dropbox
    inputs.zen-browser.packages."${system}".specific 
   ];
}
