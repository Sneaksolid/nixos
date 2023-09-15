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
      "${self}/modules/home-hyprland.nix"
      "${self}/modules/home-alacritty.nix"
      "${self}/modules/home-nvim.nix"
      "${self}/modules/home-zsh.nix"
      "${self}/modules/home-slack.nix"
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
      plasma-manager.homeManagerModules.plasma-manager
      "${self}/modules/home-conf-base.nix"
      "${self}/modules/home-plasma-config.nix"
      "${self}/modules/home-alacritty.nix"
      "${self}/modules/home-nvim.nix"
      "${self}/modules/home-zsh.nix"
      "${self}/modules/home-discord.nix"
      "${self}/modules/home-slack.nix"
      "${self}/modules/home-work.nix"
    ];
  };
}
