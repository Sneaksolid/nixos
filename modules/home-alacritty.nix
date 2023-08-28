{ self, pkgs, ... }:

{

  home.file = {
    ".config/alacritty/theme.yml".source =
      "${self}/themes/alacritty/theme.yml";
  };

  programs.alacritty = (
    import "${self}/pkgs/alacritty/config.nix"
      { inherit pkgs; }
  );
}
