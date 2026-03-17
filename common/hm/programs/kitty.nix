{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "CaskaydiaCove NF";
      size = 10;
    };
    settings = {
      term = "xterm-256color";
      scrollback_lines = 3000;
      background_opacity = "0.8";
      window_padding_width = 10;
      font_features = "CaskaydiaCoveNerdFont-Regular +liga +calt";

      # Allow remote control for theme updates
      allow_remote_control = "yes";
      listen_on = "unix:/tmp/kitty-juan";
      
      # These settings help with tmux transparency
      background_blur = 0;
      
      # Dynamic background opacity to work with tmux
      dynamic_background_opacity = "yes";

      # Theme colors
      foreground = "#FFFFFF";
      background = "#0A0A0A";

      selection_foreground = "#0A0A0A";
      selection_background = "#FF0000";

      url_color = "#73daca";
      cursor = "#FF4444";
      cursor_text_color = "#FFFFFF";
      cursor_trail = 200;
      cursor_trail_decay = "0.1 0.4";
      cursor_trail_start_thresold = 2;


      active_tab_foreground = "#0A0A0A";
      active_tab_background = "#FF0000";

      inactive_tab_foreground = "#4A4A4A";
      inactive_tab_background = "#0A0A0A";

      color0 = "#1A1A1A";
      color1 = "#DD0000";
      color2 = "#FF9999";
      color3 = "#FF6666";
      color4 = "#FF0000";
      color5 = "#FF4444";
      color6 = "#FF5555";
      color7 = "#32CD32";
      color8 = "#4A4A4A";
      color9 = "#DD0000";
      color10 = "#FF9999";
      color11 = "#FF6666";
      color12 = "#FF0000";
      color13 = "#FF4444";
      color14 = "#FF5555";
      color15 = "#32CD32";

      tab_bar_style = "powerline";
      tab_powerline_style = "round";
    };
    extraConfig = ''
    '';
  };

 home.sessionVariables = {
    KITTY_LISTEN_ON = "unix:/tmp/kitty-juan";
  };
}
