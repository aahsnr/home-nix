{ config, pkgs, ...}: 

{
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Frappe-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["pink"];
        tweaks = ["rimless"];
        size = "compact";
        variant = "frappe";
      };
    };

    iconTheme = {
      package = pkgs.catppuccin-papirus-folders;
      name = "Papirus";
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 13;
    };
    gtk3.bookmarks = [
      "file://${config.home.homeDirectory}/Dev"
      "file://${config.home.homeDirectory}/Documents"
      "file://${config.home.homeDirectory}/Downloads"
      "file://${config.home.homeDirectory}/Music"
      "file://${config.home.homeDirectory}/Pictures"
      "file://${config.home.homeDirectory}/Videos"
    ];
    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
  };

  home = {
    packages = with pkgs; [
      qt5.qttools
      qt6Packages.qtstyleplugin-kvantum
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      breeze-icons
      kdePackages.qt6ct
    ];

    pointerCursor = {
      package = pkgs.catppuccin-cursors.macchiatoMauve;
      name = "Bibata-Modern-Ice";
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    sessionVariables = {
      XCURSOR_SIZE = "16";
      GTK_USE_PORTAL = "1";
    };
  };
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style = {
      name = "Catppuccin-Frappe-Dark";
      package = pkgs.catppuccin-kde.override {
        flavour = ["frappe"];
        accents = ["pink"];
      };
    };
  };
  # xdg.configFile = {
  #   "Kvantum/catppuccin/catppuccin.kvconfig".source = builtins.fetchurl {
  #     url = "https://raw.githubusercontent.com/catppuccin/Kvantum/main/src/Catppuccin-Frappe-Pink/Catppuccin-Frappe-Pink.kvconfig";
  #     sha256 = "0pl936nchif2zsgzy4asrlc3gvv4fv2ln2myrqx13r6xra1vkcqs";
  #   };
  #   "Kvantum/catppuccin/catppuccin.svg".source = builtins.fetchurl {
  #     url = "https://raw.githubusercontent.com/catppuccin/Kvantum/main/src/Catppuccin-Frappe-Pink/Catppuccin-Frappe-Pink.svg";
  #     sha256 = "1b92j0gb65l2pvrf90inskr507a1kwin1zy0grwcsdyjmrm5yjrv";
  #   };
  #   "Kvantum/kvantum.kvconfig".text = ''
  #     [General]
  #     theme=catppuccin

  #     [Applications]
  #     catppuccin=qt5ct, org.qbittorrent.qBittorrent, hyprland-share-picker
  #   '';
  # };
}
