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
              echo 1 > "$device"/pp_power_profile_mode
      
              # The other power profile modes are:
              #   1 = 3D_FULL_SCREEN
              #   4 = VR
              #   5 = COMPUTE
      
          fi
      done
    '';
  };
}
