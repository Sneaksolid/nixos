{ ... }:

{
  enable = true;
  settings = {
    import = [
      "$HOME/.config/alacritty/theme.yml"
    ];
    font = {
      normal = {
        family = "JetBrains Mono Nerd Font";
        style = "Regular";
      };
    };
  };
}
