{ pkgs, ... }:

{
  users.users.mathias = {
    isNormalUser = true;
    home = "/home/mathias";
    description = "Mathias";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "video"
      "input"
      "sys"
      "audio"
      "docker"
      "networkmanager"
    ];
  };
}
