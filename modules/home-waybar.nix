{ self, pkgs, ... }:

{
  home.packages = with pkgs; [
    waybar
  ];

  services.mpd = {
    enable = true;
    musicDirectory = "$HOME/Music";
  };

  home.file = {
    waybar_conf = {
      recursive = true;
      source = "${self}/pkgs/waybar";
      target = ".config/waybar";
    };
  };
}
