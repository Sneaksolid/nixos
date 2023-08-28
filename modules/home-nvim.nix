{ self, ... }:

{
  home.file = {
    nvim_conf = {
      recursive = true;
      source = "${self}/pkgs/nvim";
      target = ".config/nvim";
    };
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
  };
}
