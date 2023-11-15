{ self, nixpkgs, home-manager, system, ... }:

let
  hm-config = [
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    }
  ];

  chiliCustom = final: prev: {
    chiliCustom = prev.callPackage "${self}/pkgs/sddm-themes/chili" {};
  };
in
{
  xpsFrank = nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      "${self}/modules/base.nix"
      "${self}/modules/suspend-then-hibernate.nix"
      "${self}/modules/users.nix"
      "${self}/modules/vm.nix"
      "${self}/hardware/xpsFrank.nix"
    ] ++ hm-config;
  };

  desktopFrank = nixpkgs.lib.nixosSystem {
    inherit system;

    modules = [
      ({ ... }: { nixpkgs.overlays = [ chiliCustom ]; })
      "${self}/modules/base.nix"
      "${self}/modules/users.nix"
      "${self}/modules/amdgpu-powerstate.nix"
      "${self}/hardware/desktopFrank.nix"
    ] ++ hm-config;
  };
}

