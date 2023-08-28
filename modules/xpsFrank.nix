{ ... }:

{
  networking.hostName = "xpsFrank";
  programs.hyprland.enable = true;

  security.pam.services.swaylock = { };
  hardware.bluetooth.enable = true;

  powerManagement.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    };
  };
}
