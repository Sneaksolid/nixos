{ system, nixpkgs, home-manager, ... }:

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
	{
	  home = {
	    inherit username homeDirectory;
	    stateVersion = "23.05";
	    packages = with pkgs; [ neofetch ];

	    programs = {
	      home-manager.enable = true;
	    };
	  }; 
	}
      ];
    }; 
  }
