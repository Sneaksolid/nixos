{ self, config, lib, pkgs, modulesPath, ... }:


{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [
    "amdgpu.ppfeaturemask=0xffffffff"
    # "amd_pstate=guided"
  ];

  # disable ipv6
  networking.enableIPv6 = false;


  boot.swraid.enable = false;
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/0d50ec4e-9c78-45a8-8b01-7b24141d6f33";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/1505-0892";
      fsType = "vfat";
    };

  fileSystems."/tmp" =
    {
      device = "tmpfs";
      fsType = "tmpfs";
      options = [ "size=12G" "rw" "nodev" "nosuid" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/0fb54118-318d-4430-a2dc-dd518c133a99"; }
    ];


  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;


  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = true;
  powerManagement.enable = lib.mkDefault true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  i18n.defaultLocale = "en_US.UTF-8";

  networking.hostName = "desktopFrank";
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.pam.services.swaylock = { };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.gnome.gnome-keyring.enable = true;

  nixpkgs.config.allowUnfree = true;
  # install linux firmware
  hardware.enableAllFirmware = true;
  environment.systemPackages = with pkgs; [
  ];
}

