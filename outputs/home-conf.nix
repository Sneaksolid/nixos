{ self
, system
, nixpkgs
, home-manager
, sops-nix
, plasma-manager
, ...
}:

let
  username = "mathias";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    config.xdg.configHome = configHome;
    overlays = [
      (final: prev: {swagger-ui-watcher = prev.callPackage "${self}/pkgs/swagger-ui-watcher" {};})
    ];
  };
in
{
  "mathias@xpsFrank" = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;

    extraSpecialArgs = {
      inherit system;
      inherit username;
      inherit homeDirectory;
      inherit self;
      mainMod = "SUPER";
    };

    modules = [
      sops-nix.homeManagerModules.sops
      "${self}/modules/home-conf-base.nix"
      "${self}/modules/home-sway.nix"
      "${self}/modules/home-sway-xps-outputs.nix"
      "${self}/modules/home-waybar.nix"
      "${self}/modules/home-mako.nix"
      "${self}/modules/home-wofi.nix"
      "${self}/modules/home-alacritty.nix"
      "${self}/modules/home-nvim.nix"
      "${self}/modules/home-zsh.nix"
      "${self}/modules/home-slack.nix"
      "${self}/modules/home-teams.nix"
      "${self}/modules/home-work.nix"
    ];
  };


  "mathias@winFrank" = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;

    extraSpecialArgs = {
      inherit system;
      inherit username;
      inherit homeDirectory;
      inherit self;
      mainMod = "SUPER";
    };

    modules = [
      sops-nix.homeManagerModules.sops
      "${self}/modules/home-conf-base.nix"
      "${self}/modules/home-nvim.nix"
      "${self}/modules/home-zsh.nix"
      "${self}/modules/home-zsh-wsl.nix"
      "${self}/modules/home-work.nix"
    ];
  };


  "mathias@desktopFrank" = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;

    extraSpecialArgs = {
      inherit system;
      inherit username;
      inherit homeDirectory;
      inherit self;
      mainMod = "SUPER";
    };

    modules = [
      sops-nix.homeManagerModules.sops
      "${self}/modules/home-conf-base.nix"
      "${self}/modules/home-sway.nix"
      "${self}/modules/home-sway-desktop-outputs.nix"
      "${self}/modules/home-waybar.nix"
      "${self}/modules/home-mako.nix"
      "${self}/modules/home-wofi.nix"
      "${self}/modules/home-alacritty.nix"
      "${self}/modules/home-nvim.nix"
      "${self}/modules/home-zsh.nix"
      "${self}/modules/home-slack.nix"
      "${self}/modules/home-teams.nix"
      "${self}/modules/home-work.nix"
    ];
  };
}
