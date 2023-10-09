{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  users.users.mathias = {
    extraGroups = [
      "gamemode"
    ];
  };
}
