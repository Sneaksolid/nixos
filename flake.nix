{
  description = "Sneaksolids system configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix.url = "github:mic92/sops-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = (
        import "${self}/outputs/dev-shell.nix" {
          inherit self system nixpkgs;
        }
      );

      formatter.${system} = pkgs.nixpkgs-fmt;

      nixosConfigurations = (
        import "${self}/outputs/nixos-conf.nix" {
          inherit self system nixpkgs home-manager;
        }
      );

      homeConfigurations = (
        import "${self}/outputs/home-conf.nix" {
          inherit self system nixpkgs home-manager sops-nix;
        }
      );
    };
}
