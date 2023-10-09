{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mangohud
    # for mods
    transmission-qt

    #STL deps
    unzip
    wget
    xdotool
    yad
    xorg.xwininfo

    # extra launchers
    heroic
  ];
}
