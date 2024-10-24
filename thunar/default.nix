{ pkgs, ... }:

{
  home.packages = with pkgs.xfce; [
    thunar
    thunar-archive-plugin
    thunar-dropbox-plugin
    thunar-media-tags-plugin
    thunar-volman
  ];
}
