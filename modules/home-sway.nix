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
      };

      input = {
        "*" = {
          xkb_layout = "de";
          xkb_options = "caps:escape";
          repeat_delay = "300";
          repeat_rate = "50";
        };
      };

      window.titlebar = false;

      gaps = {
        inner = 5;
        outer = 10;
      };

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

  programs.zsh.initExtra = ''
    hostname=$(hostname)
    if [[ "$hostname" = "xpsFrank" ]] || [[ "$hostname" = "desktopFrank" ]]; then
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        	exec sway
        fi
    fi
  '';
}
