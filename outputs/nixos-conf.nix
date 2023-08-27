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
      "${self}/modules/users.nix"
      "${self}/modules/xpsFrank.nix"
      "${self}/hardware/xpsFrank.nix"
    ] ++ hm-config;
  };
}

