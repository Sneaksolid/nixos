{ ... }:

{
  networking.hostName = "nixos-vm";
  services.qemuGuest.enable = true;

  # enable hyprland
  programs.hyprland.enable = true;
}
