{ self, pkgs, lib, ... }:

with lib;

let
  modifier = "Mod4";
in
{
  home.packages = with pkgs; [
    wl-clipboard
    networkmanagerapplet
    swaylock
    brightnessctl
    playerctl
    pavucontrol
    blueman
    pamixer
    flat-remix-icon-theme
    xfce.thunar
    evince
  ];

  xdg.configFile."mimeapps.list".force = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  };

  home.sessionVariables = {
    _JAVA_AWT_WM_NOREPARENTING = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    WLR_DRM_NO_MODIFIERS = "1";
  };

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
    gtk.enable = true;
  };

  wayland.windowManager.sway = {
    enable = true;

    extraConfig = ''
      set $lockCmd 'swaylock -C ${self}/pkgs/swaylock/config -i ${self}/pkgs/sway/wallpaper.jpg'
      bindswitch --reload --locked lid:on exec $lockCmd
    '';

    config = rec {
      inherit modifier;
      startup = [
        { command = "nm-applet --indicator"; }
      ];

      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar";
        }
      ];

      output = {
        "*" = {
          bg = "${self}/pkgs/sway/wallpaper.jpg fill";
        };

        "eDP-1" = {
          scale = "1.2";
        };
      };

      input = {
        "*" = {
          xkb_layout = "de";
          xkb_options = "caps:escape";
          repeat_delay = "300";
          repeat_rate = "50";
        };

        "type:touchpad" = {
          accel_profile = "adaptive";
          pointer_accel = "0.2";
          tap = "enabled";
        };
      };

      window.titlebar = false;

      gaps = {
        inner = 5;
        outer = 10;
      };

      workspaceOutputAssign = [
        { output = "eDP-1"; workspace = "1"; }

        { output = "Lenovo Group Limited P27h-20 V906BZ70"; workspace = "2"; }
        { output = "Lenovo Group Limited P27h-20 V906BZ70"; workspace = "3"; }
        { output = "Lenovo Group Limited P27h-20 V906BZ70"; workspace = "4"; }
        { output = "Lenovo Group Limited P27h-20 V906BZ70"; workspace = "5"; }
        { output = "Lenovo Group Limited P27h-20 V906BZ70"; workspace = "6"; }
        { output = "Lenovo Group Limited P27h-20 V906BZ70"; workspace = "7"; }

        { output = "Lenovo Group Limited LEN P27h-10 0x00007B38"; workspace = "9"; }
      ];

      keybindings = mkOptionDefault {
        "${modifier}+q" = "kill";
        "${modifier}+Shift+x" = "exec $lockCmd";
        "XF86AudioRaiseVolume" = "exec pamixer -ui 5";
        "XF86AudioLowerVolume" = "exec pamixer -ud 5";
        "XF86AudioMute" = "exec pamixer -t";

        "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
      };
    };
  };
}