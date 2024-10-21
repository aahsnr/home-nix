{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = false;

    fontconfig = {
      enable = true;
      antialias = true;

      defaultFonts = let
        addAll = builtins.mapAttrs (_: v: ["Ubuntu Nerd Font"] ++ v ++ ["Noto Color Emoji"]);
      in
        addAll {
          serif = ["Noto Serif"];
          sansSerif = ["Inter"];
          monospace = ["Ubuntu Mono"];
          emoji = [];
        };

      hinting = {
        enable = true;
        autohint = false;
        style = "full";
      };

      subpixel = {
        lcdfilter = "default";
        rgba = "rgb";
      };
    };

    fontDir = {
      enable = true;
      decompressFonts = true;
    };

    packages = with pkgs; [
      # System Fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji

      # Monospace
      jetbrains-mono
      ubuntu_font_family

      # Icon Fonts
      material-design-icons
      material-symbols

      # Custom Fonts
      (google-fonts.override {fonts = ["Inter"];})
      (nerdfonts.override {fonts = ["Ubuntu JetBrainsMono"];})
    ];
  };
}
