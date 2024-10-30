{ inputs, pkgs, config, packages, self, rust-overlay, ...}:

{
  home.packages = with pkgs; [
    cachix
    bitwarden-desktop
    onlyoffice-bin
    vivaldi
    vivaldi-ffmpeg-codecs
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
    nixgl.auto.nixGLDefault
    nheko
    #nixgl.auto.nixGLNvidia
    #nixgl
    #rust-bin.stable.latest.minimal 
  ];
}
