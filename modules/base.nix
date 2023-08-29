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

  # limits
  security.pam.loginLimits = [{
    domain = "*";
    type = "soft";
    item = "nofile";
    value = "8192";
  }];

  boot.kernel.sysctl."fs.inotify.max_user_instances" = 8192;

  ## audio stuff
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.blueman.enable = true;
  services.fwupd.enable = true;

  environment.etc = {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      		bluez_monitor.properties = {
      			["bluez5.enable-sbc-xq"] = true,
      			["bluez5.enable-msbc"] = true,
      			["bluez5.enable-hw-volume"] = true,
      			["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      		}
      	'';
  };

  programs = {
    zsh.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    autoPrune.enable = true;
    daemon.settings = {
      insecure-registries = [ "k3d-local:5111" ];
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

