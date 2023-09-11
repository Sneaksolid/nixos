{ self, pkgs, mainMod, ... }:

{
  home.packages = with pkgs; [
    hyprpaper
    wl-clipboard
    networkmanagerapplet
    waybar
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

  home.file = {
    hyprpaper_conf = {
      source = "${self}/pkgs/hyprland/hyprpaper.conf";
      target = ".config/hypr/hyprpaper.conf";
    };

    wallpaper_jpg = {
      source = "${self}/pkgs/hyprland/wallpaper.jpg";
      target = ".config/hypr/wallpaper.jpg";
    };

    hyprland_theme = {
      source = "${self}/themes/hyprland/mocha.conf";
      target = ".config/hypr/themes/mocha.conf";
    };

    waybar_conf = {
      recursive = true;
      source = "${self}/pkgs/waybar";
      target = ".config/waybar";
    };

    wofi_conf = {
      recursive = true;
      source = "${self}/pkgs/wofi";
      target = ".config/wofi";
    };

    swaylock = {
      recursive = true;
      source = "${self}/pkgs/swaylock";
      target = ".config/swaylock";
    };

    hypr_scripts = {
      recursive = true;
      source = "${self}/pkgs/hyprland/scripts";
      target = ".config/hypr/scripts";
    };
  };

  home.sessionVariables = {
    _JAVA_AWT_WM_NOREPARENTING = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
  };

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
    gtk.enable = true;
  };

  wayland.windowManager.hyprland = (
    import "${self}/pkgs/hyprland/config.nix"
      { inherit mainMod; }
  );

  programs.wofi = {
    enable = true;
  };

  services.mako = {
    enable = true;
    defaultTimeout = 5;
  };

  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";

    profiles = {
      mobile = {
        outputs = [
          {
            criteria = "eDP-1";
            mode = "1920x1200";
            position = "0,0";
            scale = 1.2;
          }
        ];
      };

      office = {
        outputs = [
          {
            criteria = "eDP-1";
            mode = "1920x1200";
            position = "0,0";
            scale = 1.2;
          }
          {
            criteria = "Lenovo Group Limited P27h-20 V906BZ70";
            mode = "2560x1440";
            scale = 1.0;
            position = "1600,0";
          }
          {
            criteria = "Lenovo Group Limited LEN P27h-10 0x385A5938";
            mode = "2560x1440";
            scale = 1.0;
            position = "4160,0";
          }
        ];
      };
    };
  };
}
