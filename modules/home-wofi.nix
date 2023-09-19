{ self, ... }:
{
  home.file = {
    wofi_conf = {
      recursive = true;
      source = "${self}/pkgs/wofi";
      target = ".config/wofi";
    };
  };

  programs.wofi.enable = true;
  wayland.windowManager.sway.config.menu = "wofi";
}
