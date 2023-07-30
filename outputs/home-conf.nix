{ self, system, nixpkgs, home-manager, ... }:


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
  "mathias@nixos-vm" = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;

    extraSpecialArgs = {
      inherit username;
      inherit homeDirectory;
      inherit self;
      mainMod = "ALT";
    };

    modules = [
      "${self}/modules/home-conf-base.nix"
      "${self}/modules/home-hyprland.nix"
    ];
  };
}
