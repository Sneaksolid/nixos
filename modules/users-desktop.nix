{ pkgs, ... }:

{
  users.users.mathias = {
    extraGroups = [
      "gamemode"
    ];
  };
}
