{ self, mainMod, ... }:

{
  wayland.windowManager.hyprland = (
    import "${self}/pkgs/hyprland/config.nix"
      { inherit mainMod; }
  );
}
