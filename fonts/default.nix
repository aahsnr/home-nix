{ config, pkgs, nixpkgs, ...}: 

{ 
  home.packages = with pkgs; [
    corefonts
    fira-code
    fira-code-symbols
    ubuntu_font_family
    jetbrains-mono
    (google-fonts.override {fonts = ["Inter"];})
    (nerdfonts.override {fonts = ["Ubuntu" "JetBrainsMono"];})
  ];

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts.monospace = [ "Ubuntu Mono" ];
    };
  };
}
