{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    plugins.lualine.enable = true;
  };
}
