{ self, pkgs, username, homeDirectory, ... }:

{
  home = {
    inherit username homeDirectory;
    stateVersion = "23.05";
    packages = with pkgs; [
      neofetch
      nerdfonts
    ];

    file = {
      ".config/alacritty/theme.yml".source = "${self}/themes/alacritty/theme.yml";
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

    alacritty = {
      enable = true;
      settings = {
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
