{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mangohud
    steamtinkerlaunch
  ];
}
