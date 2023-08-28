{ self, pkgs, ... }:

{
  home.file = {
    nvim_conf = {
      recursive = true;
      source = "${self}/pkgs/nvim";
      target = ".config/nvim";
    };
  };

  home.packages = with pkgs; [
      gcc
      nixd
      gcc
      nodejs_18
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
  };
}
