{ pkgs, username, homeDirectory, ... }:

{
  home = {
    inherit username homeDirectory;
    stateVersion = "23.05";
    packages = with pkgs; [
      neofetch
      nerdfonts
    ];

  };

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      aliases = {
        co = "checkout";
      };
      userName = "Mathias Kahr";
      userEmail = "m.kahr@trever.io";
    };
  };
}
