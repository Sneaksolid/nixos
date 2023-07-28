{self, nixpkgs, system, ...}:

{
  qemu = nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      "${self}/modules/base.nix"
      "${self}/modules/qemu.nix"
      "${self}/hardware/qemu.nix"
    ];
  };
}

