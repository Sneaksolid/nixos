{ mainMod, ... }:

{
  enable = true;
  settings = {
    "$mainMod" = "${mainMod}";
    "$lockCmd" = "swaylock -c $HOME/.config/swaylock/config";

    input = {
      kb_layout = "de";
      kb_variant = "";
      kb_model = "";
      kb_options = "caps:escape";
      kb_rules = "";
      repeat_delay = 300;
      repeat_rate = 50;

      follow_mouse = 1;

      touchpad = {
        natural_scroll = "no";
      };

      sensitivity = 0;
    };

    bind = [
      "$mainMod, RETURN, exec, alacritty"
      "$mainMod, Q, killactive, "
      "$mainMod SHIFT, C, exit, "
      "$mainMod, O, togglefloating, "
      "$mainMod, D, exec, wofi --show drun"
      "$mainMod SHIFT, D, exec, wofi --show run"
      "$mainMod, P, pseudo, # dwindle"
      "$mainMod, V, togglesplit, # dwindle"
      "$mainMod, F, fullscreen,"
      "$mainMod SHIFT, X, exec, $lockCmd"
      "$mainMod SHIFT, W, exec, $HOME/.config/hypr/scripts/moveworkspace.sh"

      "$mainMod, H, movefocus, l"
      "$mainMod, L, movefocus, r"
      "$mainMod, K, movefocus, u"
      "$mainMod, J, movefocus, d"

      "$mainMod SHIFT, H, movewindow, l"
      "$mainMod SHIFT, L, movewindow, r"
      "$mainMod SHIFT, K, movewindow, u"
      "$mainMod SHIFT, J, movewindow, d"

      # Switch workspaces with mainMod + [0-9]
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"

      # Scroll through existing workspaces with mainMod + scroll
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"
    ];
  };
}
