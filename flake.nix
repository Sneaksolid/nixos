{
  description = "Sneaksolids system configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
    let
      system = "x86_64-linux";
    in
      {
	devShells.${system}.default = (
	  import "${self}/outputs/dev-shell.nix" {
	    inherit self system nixpkgs;
	  }
	);

        nixosConfigurations = (
	  import "${self}/outputs/nixos-conf.nix" {
	    inherit self system nixpkgs;
	  }
	);

	homeConfigurations = (
	  import "${self}/outputs/home-conf.nix" {
	    inherit self system nixpkgs home-manager;
	  }
	);
      };
}
