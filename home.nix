{ inputs, pkgs, config, lib, self, ... }:

{
  home = {
    username = "ahsan";
    homeDirectory = "/home/ahsan";
    stateVersion = "24.11";
    extraOutputsToInstall = ["doc" "info" "devdoc"];

    #--- Setting Session Variables ---
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "brave";
      TERMINAL = "alacritty";
    };

    #--- Setting Session Path ---
    sessionPath = [
      "$HOME/.local/bin"
      "/usr/libexec"
    ];
  };


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  imports = [ 
    ./ags
    ./alacritty
    ./anyrun
    ./bat
    ./fonts
    ./foot
    ./git
    ./hyprland
    ./kitty
    ./lazygit
    ./mpv
    ./pkgs
    ./tealdeer
    ./theming
    ./thunar
    #./texlive #old libraries
    ./zathura
    ./zoxide
    inputs.ags.homeManagerModules.default
    inputs.anyrun.homeManagerModules.default
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      allowUnfreePredicate = true;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
