# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "23.05";

  # Generic system config
  
  time.timeZone = "Europe/Vienna";
  
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  ## system packages
  environment.systemPackages = with pkgs; [
    vim
  ];

  ## services
  services.qemuGuest.enable = true;

  ## system config
  console.keyMap = "de";

}

