{ config, pkgs, ... }:

{
  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    package = pkgs.yabai;
    config = {
      layout = "bsp";
      window_placement = "second_child";
      top_padding = 10;
      bottom_padding = 10;
      left_padding = 10;
      right_padding = 10;
      window_gap = 10;
      mouse_follows_focus = "on";
      mouse_modifier = "alt";
      mouse_action1 = "move";
      mouse_action2 = "resize";
    };
    extraConfig = ''
      yabai -m rule --add app="^System Settings$" manage=off
      yabai -m rule --add app="^Finder$" manage=off
      yabai -m rule --add app="^Calculator$" manage=off
      yabai -m rule --add app="^Brave Browser$" title!=".*Incognito.*" space=1
      yabai -m rule --add title=".*Private.*Inactive tab.*" space=9
      yabai -m rule --add app="^WezTerm$" space=2
      yabai -m rule --add app="^Xcode$" space=3
      yabai -m rule --add app="^Spotify$" space=9
      yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
    '';
  };
}
