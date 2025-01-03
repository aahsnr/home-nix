{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      cursor = {
        unfocused_hollow = false;
        style = {
          blinking = "On";
          shape = "Block"; 
        };
      };
      env = {
        TERM = "alacritty";
        WINIT_X11_SCALE_FACTOR = "1.0";
      };
      font = {
        size = 22;
        bold.family = "Ubunut Nerd Font";
        bold_italic.family = "Ubuntu Nerd Font";
        italic = "Ubuntu Nerd Font";
        normal = "Ubuntu Nerd Font";
        offset = {
          x = 0;
          y = 0;
        };
      };
      colors = {
        bright = {
          black = "#4C566A";
          blue = "#81A1C1";
          cyan = "#8FBCBB";
          green = "#A3BE8C";
          magenta = "#B48EAD";
          red = "#BF616A";
          yellow = "#EBCB8B";
        };
        normal = {
          black = "#3B4252";
          blue = "#81A1C1";
          cyan = "#88C0D0";
          green = "#A3BE8C";
          magenta = "#B48EAD";
          red = "#BF616A";
          white = "#E5E9F0";
          yellow = "#EBCB8B";
        };
        primary = {
          background = "#1E1E2E";
          foreground = "#CDD6F4";
        };
      };
      window = { 
        decorations = "full";
        dynamic_title = true;
        opacity = 0.95;
        startup_mode = "Windowed";
        dimensions = {
          columns = 82;
          lines = 23;
        };
        padding = {
          x = 10;
          y = 10;
        };
      };
    };
  };
}

