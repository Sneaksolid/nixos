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
    exa
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
      ls = "exa";
      grep = "rg";
      find = "fd";
      ps = "procs";
    };
    initExtra = ''
                        if [[ "$hostname" = "xpsFrank" ]]; then
                  
                        	eval "$(zoxide init zsh)"
                        	alias cd=z
                        	if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
                        	  exec Hyprland
                        	fi
                        fi
      		'';
  };
}
