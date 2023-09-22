{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (makeDesktopItem {
      name = "teams";
      exec = "${pkgs.ungoogled-chromium}/bin/chromium --new-window --app=https://teams.microsoft.com";
      desktopName = "Teams";
      icon = "${pkgs.tela-circle-icon-theme}/share/icons/Tela-circle/scalable/apps/teams-for-linux.svg";
    }
    )
  ];
}
