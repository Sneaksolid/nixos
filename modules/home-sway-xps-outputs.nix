{ self, pkgs, ...}:

{
  wayland.windowManager.sway = {
    config = {

      output = {
        "eDP-1" = {
          scale = "1.2";
        };
      };

      input = {
        "type:touchpad" = {
          accel_profile = "adaptive";
          pointer_accel = "0.2";
          tap = "enabled";
        };
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
    };
  };
}
