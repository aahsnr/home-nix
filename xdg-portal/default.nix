{ inputs, pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    configPackages = [ inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland  ];
    xdgOpenUsePortal = true;
    config = {
      common.default = ["gtk"];
      hyprland.default = ["gtk" "hyprland"];
    };

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
