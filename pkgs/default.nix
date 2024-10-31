{ inputs, pkgs, config, packages, self, nixgl, lib, ...}:

{

  nixGL = {
    packages = nixgl.packages;
    defaultWrapper = "mesa";
    # offloadWrapper = "nvidiaPrime";
    installScripts = [ "mesa" "nvidiaPrime" ];
  };

  home.packages = [
    pkgs.cachix
    pkgs.bitwarden-desktop
    pkgs.onlyoffice-bin
    pkgs.vivaldi
    pkgs.vivaldi-ffmpeg-codecs
    pkgs.brave
    pkgs.spotify
    pkgs.unzip
    #(config.lib.nixGL.wrapOffload pkgs.pymol)
   pkgs.xournalpp
   pkgs.deluge-gtk
   pkgs.spotify
   pkgs.gcc
   pkgs.cmake
   pkgs.nix-prefetch-git
   pkgs.nix-prefetch-github
   pkgs.nwg-drawer
   pkgs.nwg-look
   pkgs.nwg-hello
   pkgs.sbctl
   pkgs.zotero
   pkgs.nixgl.auto.nixGLDefault
    pkgs.nixgl.auto.nixGLNvidiaBumblebee
    pkgs.nheko
    #nixgl.auto.nixGLNvidia
    #nixgl
    #rust-bin.stable.latest.minimal 
  ];
}
