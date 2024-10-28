{ config, inputs, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    #package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
  };

  imports = [
    ./env.nix
    ./settings.nix
    ./keybindings.nix
    ./misc.nix
    ./plugins.nix
    ./rules.nix
    ./autostart.nix
  ];
}
