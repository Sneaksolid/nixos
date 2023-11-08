{ self, pkgs, ...}:

{
  wayland.windowManager.sway = {
    config = {

      output = {
        "DP-1" = {
	  position = "1440 0";
	  mode = "2560x1440@143.973Hz";
	  adaptive_sync = "off";
	};
	
	"DP-2" = {
	  position = "0 -700";
	  transform = "270";
	  mode = "2560x1440@143.998Hz";
	  adaptive_sync = "off";
	};

	"DP-3" = {
	  position = "4000 0";
	  mode = "2560x1440@143.998Hz";
	  adaptive_sync = "off";
	};
      };

      workspaceOutputAssign = [
        { output = "DP-2"; workspace = "1"; }

        { output = "DP-1"; workspace = "2"; }
        { output = "DP-1"; workspace = "3"; }
        { output = "DP-1"; workspace = "4"; }
        { output = "DP-1"; workspace = "5"; }
        { output = "DP-1"; workspace = "6"; }
        { output = "DP-1"; workspace = "7"; }

        { output = "DP-3"; workspace = "9"; }
      ];
    };
  };
}
