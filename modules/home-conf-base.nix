{ self, pkgs, system, username, homeDirectory, ... }:

let
  nerdFontPkgs = import
    (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/8cad3dbe48029cb9def5cdb2409a6c80d3acfe2e.tar.gz";
      sha256 = "181ad740l2fy6phsz45jlvhnshhz4nvvl900vm1kvn9bhlc1ih95";
    })
    { inherit system; };

  nerfontsOld = nerdFontPkgs.nerdfonts;
in
{
  home = {
    inherit username homeDirectory;
    stateVersion = "23.05";
    packages = with pkgs; [
      neofetch
      nerfontsOld
      firefox
      btop
      sops
      bitwarden
      telegram-desktop
      spotify
      slack
      curl
    ];

    sessionVariables = {
      EDITOR = "vim";
      PATH = "$PATH:$HOME/go/bin:$HOME/.local/bin:$HOME/.config/hypr/scripts:/opt/flutter/bin";
      DEV_ENVIRONMENT = "mka";
      GOPATH = "$HOME/go";
      MOZ_ENABLE_WAYLAND = "1";
      DOCKER_BUILDKIT = "1";
    };
  };

  gtk.enable = true;

  sops = {
    age.keyFile = "${homeDirectory}/.config/sops/age/keys.txt";
  };

  fonts.fontconfig.enable = true;
  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      aliases = {
        co = "checkout";
      };
      userName = "Mathias Kahr";
      userEmail = "m.kahr@trever.io";
    };
  };
}
