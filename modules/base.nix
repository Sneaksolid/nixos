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
  environment.etc."ppp/options".text = "ipcp-accept-remote";

  ## default packages
  ## ensure vim is installed in case
  ## we need to edit something
  environment.systemPackages = with pkgs; [
    vim
  ];

  ## system config
  console.keyMap = "de";

  # limits
  security.pam.loginLimits = [{
    domain = "*";
    type = "soft";
    item = "nofile";
    value = "8192";
  }];

  boot.kernel.sysctl."fs.inotify.max_user_instances" = 8192;

  programs = {
    zsh.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    autoPrune.enable = true;
    logDriver = "local";
    daemon.settings = {
      insecure-registries = [ "k3d-local:5111" ];
      log-opts = {
        "max-size" = "10m";
        "max-file" = "3";
      };
    };
  };

  # networking

  networking.firewall = {
    allowedTCPPorts = [
      6379 # redis
      5432 # postgres
      9092 # kafka
      4566 # localstack api
    ];

    allowedTCPPortRanges = [
      { from = 4510; to = 4559; } # localstack services
    ];
  };

  networking.extraHosts = ''
      	127.0.0.1 api.local.trever.io	
    	127.0.0.1 k3d-local
  '';
}

