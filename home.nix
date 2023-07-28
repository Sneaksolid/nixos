{ config, pkgs, ... }:

{
  home.stateVersion = "23.05";
  home.username = "mathias";
  home.homeDirectory = "/home/mathias";

  home.packages = with pkgs; [
    firefox
    neofetch
  ];
  
  programs = {
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
