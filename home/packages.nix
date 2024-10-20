{ inputs, pkgs, config, self, ...}:

{
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  home.packages = with pkgs; [
    alacritty
    lutris
    brave
    neovim
    lunarvim
    git
    cached-nix-shell 
    typescript
    fzf
    nodejs
    spotify
    gjs
    bun
    cargo
    lynis
    unzip
    ripgrep
    ffmpeg
    pymol
    xournalpp
    imagemagick
    transmission_4-gtk
    fd
    jq 
    lm_sensors
    spotify
    catppuccin-gtk
  ];
}
