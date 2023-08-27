{ self, pkgs, username, homeDirectory, ... }:

{
  home = {
    inherit username homeDirectory;
    stateVersion = "23.05";
    packages = with pkgs; [
      neofetch
      nerdfonts
      firefox
      gcc
      nixd
      hyprpaper
      wl-clipboard
      networkmanagerapplet
      waybar
      mako

      # node
      nodejs_18

      # gnome
      gnome.gnome-keyring
    ];

    file = {
      ".config/alacritty/theme.yml".source = 
        "${self}/themes/alacritty/theme.yml";

      nvim_conf = {
        recursive = true;
	source = "${self}/pkgs/nvim";
	target = ".config/nvim";
      };

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
    };
  };

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      aliases = {
        co = "checkout";
      };
      userName = "Mathias Kahr";
      userEmail = "m.kahr@trever.io";
    };

    neovim = {
      enable = true;
      vimAlias = true;
    };

    alacritty = {
      enable = true;
      settings = {
        import = [
          "$HOME/.config/alacritty/theme.yml"
	];
        font = {
          normal = {
            family = "JetBrains Mono Nerd Font";
            style = "Regular";
          };
        };
      };
    };
  };
}
