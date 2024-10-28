{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  home = { 
    file = {
      ".config/yazi/yazi.toml".source  = ./yazi.toml;
      ".config/yazi/theme.toml".source = ./theme.toml;
      ".config/yazi/keymap.toml".source  = ./keymap.toml;
    };
  };

}

