{ config, ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "/usr/libexec/polkit-mate-authentication-agent-1"
      "thunar --daemon"
      "GDK_DPI_SCALE=1.2 ags"
      "hyprshade on ~/.config/hypr/shaders/blue-light-filter.glsl"
    ];
  };
}
