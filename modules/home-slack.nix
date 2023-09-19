{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (makeDesktopItem {
      name = "slack";
      exec = "${pkgs.ungoogled-chromium}/bin/chromium --new-window --app=https://app.slack.com/client/T7H8H6Y3B/C7HRB3W4C";
      desktopName = "Slack";
      icon = "${pkgs.tela-circle-icon-theme}/share/icons/Tela-circle/scalable/apps/slack.svg";
    }
    )
  ];
}
