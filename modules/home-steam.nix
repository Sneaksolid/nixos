{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mangohud
    gamemode
  ];
}
