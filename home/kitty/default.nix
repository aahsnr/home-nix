programs.kitty = {
  enable = true;
  font = {
    name = "JetBrainsMono Nerd Font";
    size = 16;  
  };
  environment = {
    "tab_bar_edge"          = "bottom";
    "tab_bar_margin_width"  = "0.0";
    "tab_bar_margin_height" = "0.0 0.0";
    "tab_bar_style"         =  "powerline";
    "tab_bar_align"         = "left";
  };
  settings = {
    scrollback_lines         = 2000;
    wheel_scroll_min_lines  = 1;
    remember_window_size    = yes;
    initial_window_width    = 640;
    initial_window_height   = 400;
    window_padding_width    = 5;
    allow_hyperlinks        = yes;
    confirm_os_window_close = 0;

  keybindings = {
    "ctrl+shift" = "kitty_mod";
    "ctrl+tab"   = "next_tab";
    "ctrl+shift+tab" = "previous_tab";
    "ctrl+t" = "new_tab";
    "kitty_mod+q" = "close_tab";
  };

  theme = "Catppuccin-Mocha";
  shellintegration = {
    mode = "enabled";
    enableZshIntegration = true;
  };
};
