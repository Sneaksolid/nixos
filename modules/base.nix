{ pkgs, ... }:

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

  networking.networkmanager.enable = true;

  ## default packages
  ## ensure vim is installed in case
  ## we need to edit something
  environment.systemPackages = with pkgs; [
    vim
  ];

  ## system config
  console.keyMap = "de";
}

