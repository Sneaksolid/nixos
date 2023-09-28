{ self, nixpkgs, home-manager, system, ... }:

let
  hm-config = [
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    }
  ];
in
{
  nixos-vm = nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      "${self}/modules/base.nix"
      "${self}/modules/users.nix"
      "${self}/modules/nixos-vm.nix"
      "${self}/hardware/nixos-vm.nix"
    ] ++ hm-config;
  };

  xpsFrank = nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      "${self}/modules/base.nix"
      "${self}/modules/suspend-then-hibernate.nix"
      "${self}/modules/users.nix"
      "${self}/hardware/xpsFrank.nix"
    ] ++ hm-config;
  };

  desktopFrank = nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      "${self}/modules/base.nix"
      "${self}/modules/users.nix"
      "${self}/modules/steam.nix"
      "${self}/modules/8bitdo.nix"
      "${self}/modules/amdgpu-powerstate.nix"
      "${self}/hardware/desktopFrank.nix"
    ] ++ hm-config;
  };
}

