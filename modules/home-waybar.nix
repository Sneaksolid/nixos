{ self, pkgs, ... }:

{
  home.packages = with pkgs; [
    waybar
  ];

  home.file = {
    waybar_conf = {
      recursive = true;
      source = "${self}/pkgs/waybar";
      target = ".config/waybar";
    };
  };
}
