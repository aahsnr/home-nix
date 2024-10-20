{config, pkgs, ... }:

{
  home.packages = with pkgs; [
    libsixel
  ];

  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        pad="8x8";
        initial-window-size-chars="82x23";
        resize-delay-ms="50";
        font = "JetBrainsMono Nerd Font:size=16";
        dpi-aware = "no";
      };
      scrollback = {
        lines = "1000";
        multiplier = "3.0";
      };
      cursor = {
        style = "block";
        blink = "yes";
      };
      mouse = {
        hide-when-typing = "yes";
        alternate-scroll-mode = "yes";
      };
      colors = {
        alpha = "0.93";
        foreground = "c0caf5";
        background = "1a1b26";

        regular0 = "6e6c7e";  
        regular1 = "f28fad";  
        regular2 = "abe9b3";  
        regular3 = "fae3b0";  
        regular4 = "96cdfb";  
        regular5 = "f5c2e7";  
        regular6 = "89dceb";  
        regular7 = "d9e0ee"; 

        bright0 = "988ba2";   
        bright1 = "f28fad";   
        bright2 = "abe9b3";
        bright3 = "fae3b0";   
        bright4 = "96cdfb";   
        bright5 = "f5c2e7";
        bright6 = "89dceb";   
        bright7 = "d9e0ee";
      };
    };
  };
}
