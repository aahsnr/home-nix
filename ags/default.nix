{ inputs, pkgs, ... }:

{
  programs.ags = {
    enable = true;
    configDir = ./ags;
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
      grimblast
      gpu-screen-recorder
      hyprpicker
      btop
      grim 
      slurp
      matugen
      swww
      dart-sass
      gnome-bluetooth_1_0
    ];
  };
}
