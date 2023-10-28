{ self, pkgs, homeDirectory, ... }:

{

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  programs.zsh = {
    initExtra = ''
	if [ -e /home/mathias/.nix-profile/etc/profile.d/nix.sh ]; then . /home/mathias/.nix-profile/etc/profile.d/nix.sh; fi
    '';
  };
}
