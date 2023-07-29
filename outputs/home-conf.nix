{ system, nixpkgs, home-manager, hyprland, ... }:

let 
  username = "mathias";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    config.xdg.configHome = configHome;
  };
in
  {
    mathias = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        # TODO export this to a module
	hyprland.homeManagerModules.default
	{
	  home = {
	    inherit username homeDirectory;
	    stateVersion = "23.05";
	    packages = with pkgs; [ neofetch ];

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
	  };

	  wayland.windowManager.hyprland = {
	    enable = true;
	  };
	}
      ];
    }; 
  }
