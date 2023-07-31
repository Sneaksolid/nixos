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

    general = {
      gaps_in = 5;
      gaps_out = 20;
      border_size = 1;
      # col.active_border = $sky;
      # col.inactive_border = $mantle;

      layout = "dwindle";
    };

    decoration = {
      rounding = 10;
      multisample_edges = "false";

      blur = "yes";
      blur_size = 10;
      blur_passes = 1;
      blur_new_optimizations = "true";
    };

    animations = {
      enabled = "yes";

      bezier = [
        "myBezier, 0.05, 0.9, 0.1, 1.05"
      ];

      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };

    dwindle = {
      pseudotile = "yes";
      preserve_split = "yes";
    };

    master = {
      new_is_master = "true";
    };

    gestures = {
      workspace_swipe = "on";
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

    bindm = [
       "$mainMod, mouse:272, movewindow"
       "$mainMod, mouse:273, resizewindow"
    ];

    bindl = [
      " , XF86AudioRaiseVolume, exec, pamixer -ui 2"
      " , XF86AudioLowerVolume, exec, pamixer -ud 2"
      " , XF86AudioMute, exec, pamixer -t"

      " , XF86MonBrightnessUp, exec, brightnessctl -c backlight set +5%"
      " , XF86MonBrightnessDown, exec, brightnessctl -c backlight set 5%-"
      " , switch:Lid Switch, exec, $lockCmd"
    ];
  };
}
