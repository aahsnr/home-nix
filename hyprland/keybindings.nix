{ config, ... }:

{ 
  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        #--- Terminal --
        "SUPER, Return, exec, foot"
        
        #--- Scratchpads
        "SUPERSHIFT, RETURN, exec, pypr toggle term"     
        "SUPERSHIFT, R, exec, pypr toggle ranger"

        #--- Window Management --
        "SUPER, Q, killactive,"
        "SUPER, F, fullscreen, 0"
        "SUPER, Space, togglefloating,"
        "SUPER, S, togglesplit,"       
        
        # Change Focus
        "SUPER, left,  movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up,    movefocus, u"
        "SUPER, down,  movefocus, d"

        # Move Focused Window
        "SUPERSHIFT, left,  movewindow, l"
        "SUPERSHIFT, right, movewindow, r"
        "SUPERSHIFT, up,    movewindow, u"
        "SUPERSHIFT, down,  movewindow, d"

        # Resize Focused Window
        "SUPERCTRL, left,  resizeactive, -45 0"
        "SUPERCTRL, right, resizeactive, 45 0"
        "SUPERCTRL, up,    resizeactive, 0 -45"
        "SUPERCTRL, down,  resizeactive, 0 45"

        # Switch between windows
        "SUPERSHIFT, Tab, cyclenext,"
        "SUPERSHIFT, Tab, bringactivetotop,"

        #-- GUI Apps --
        "SUPER, E, exec, emacsclient -c -a 'emacs'"
        "SUPER, B, exec, brave" 
        "SUPER, R, exec, kitty -e ranger"
        "SUPER, Z, exec, zotero"
        "SUPER, T, exec, thunar"
        "SUPERSHIFT, R, exec, jabref"
      ];
    };
  };
}
