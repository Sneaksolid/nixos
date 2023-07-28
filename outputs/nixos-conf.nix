{self, nixpkgs, system, ...}:

{
  nixos-vm = nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      "${self}/modules/base.nix"
      "${self}/modules/nixos-vm.nix"
      "${self}/hardware/nixos-vm.nix"
    ];
  };
}

