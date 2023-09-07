{ self, pkgs, system, username, homeDirectory, ... }:

let
  NFandSlackPackages = import
    (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/8cad3dbe48029cb9def5cdb2409a6c80d3acfe2e.tar.gz";
      sha256 = "181ad740l2fy6phsz45jlvhnshhz4nvvl900vm1kvn9bhlc1ih95";
    })
    { inherit system; config.allowUnfree = true; };

  nerfontsOverlay = NFandSlackPackages.nerdfonts;
  slackOverlay = NFandSlackPackages.slack;
in
{
  home = {
    inherit username homeDirectory;
    stateVersion = "23.05";
    packages = with pkgs; [
      neofetch
      nerfontsOverlay
      btop
      sops
      curl
      tmux

      # desktop apps
      spotify
      slackOverlay
      firefox
      bitwarden
      telegram-desktop
      discord
      teams
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
