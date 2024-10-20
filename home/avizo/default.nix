{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    pamixer
    light
  ];

  services.avizo = {
    enable = true;
    settings = {
      default = {
        time = 2.0;
        width = 230;
        height = 230;
        padding = 24;
        y-offset = 0.5;
        fade-in = 0.1;
        fade-out = 0.2;
        
      };
    };
  };
}
