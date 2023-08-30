{ config, ... }:

{
  gtk.gtk2.configLocation = "${config.home.homeDirectory}/.trash/.gtkrc-2.0";
}
