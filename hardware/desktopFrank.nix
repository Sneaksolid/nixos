{ self, config, lib, pkgs, modulesPath, ... }:


#corectrl = pkgs.libsForQt5.callPackage "${self}/pkgs/corectrl/default.nix" {};

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [
    "amdgpu.ppfeaturemask=0xffffffff"
    "amd_pstate=guided"
  ];

  # disable ipv6
  networking.enableIPv6 = false;


  boot.swraid.enable = false;
  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/ca835341-d560-4edc-803b-ab72eaf2d49b";
      fsType = "ext4";
      options = [ "defaults" "noatime" "commit=60" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/F7B7-B9FD";
      fsType = "vfat";
    };

  fileSystems."/tmp" =
    {
      device = "tmpfs";
      fsType = "tmpfs";
      options = [ "size=12G" "rw" "nodev" "nosuid" ];
    };

  fileSystems."/mnt/DATA" =
    {
      device = "/dev/disk/by-uuid/948378ae-80ea-4a9e-8f90-fe747a539f35";
      fsType = "ext4";
      options = [ "defaults" "noatime" "commit=60" ];
    };

  fileSystems."/mnt/NVME" =
    {
      device = "/dev/disk/by-uuid/221d1bf2-38c4-4de1-b6bc-dff366c3c6dd";
      fsType = "ext4";
      options = [ "defaults" "noatime" "commit=60" ];
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/1f5805dc-b151-4a65-ad60-4d77131c0d69"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp7s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  networking.hostName = "desktopFrank";

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.UTF-8";
    LC_IDENTIFICATION = "de_AT.UTF-8";
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";

  programs = {
    dconf.enable = true;
    gamemode = {
      enable = true;
      settings = {
        general = {
          renice = 10;
        };
      };
    };
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "at";
    xkbVariant = "nodeadkeys";
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  # install linux firmware
  hardware.enableAllFirmware = true;

  environment.systemPackages = with pkgs; [
  ];
}

