{ config, pkgs, ... }:

{
  systemd.services."set-amdgpu-power-profile" = {
    description = "sets the amdgpu power profile to 3D_FULL_SCREEN";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      type = "oneshot";
    };
    script = ''
      #!/bin/sh
      for device in /sys/class/drm/card?/device; do
          if [[ -e "$device"/pp_power_profile_mode ]]; then
      
              echo manual > "$device"/power_dpm_force_performance_level
              echo 2 > "$device"/pp_power_profile_mode

              # The other power profile modes are:
              #   1 = 3D_FULL_SCREEN
	      #   2 = POWER_SAVE
              #   4 = VR
              #   5 = COMPUTE
      
          fi

          # if [[ -e "$device"/hwmon/hwmon0/power1_cap ]]; then
          #     echo 350000000 > "$device"/hwmon/hwmon0/power1_cap
          # fi
      done
    '';
  };
}
