{ self, pkgs, homeDirectory, ... }:

{


  sops.secrets = {
    zsh_private = {
      format = "binary";
      sopsFile = "${self}/secrets/dot_zshrc_private";
      path = "${homeDirectory}/.zshrc_private";
    };
  };

  home.packages = with pkgs; [
    eza
    ripgrep
    fd
    procs
    zoxide
    fzf
    bat
  ];

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "fzf" ];
      theme = "agnoster";
    };

    shellAliases = {
      cat = "bat";
      ls = "eza";
      grep = "rg";
      find = "fd";
      ps = "procs";
    };
    initExtra = ''
      eval "$(zoxide init zsh)"
      alias cd=z
      source ~/.zshrc_private
    '';
  };
}
