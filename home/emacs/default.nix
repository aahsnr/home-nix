{ config, pkgs, lib, ... }:

{
  services.emacs = {
    enable = true;
    package = pkgs.emacsPgtk;
    extraPackages = (epkgs: [ epkgs.vterm ] );
  };
}
