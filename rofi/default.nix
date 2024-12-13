{ pkgs, config, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "foot";
    font = "JetBrainsMonon Nerd Font 14";
  };
}
