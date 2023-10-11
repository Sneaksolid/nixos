{ pkgs, ... }:
{
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
  };
  virtualisation.spiceUSBRedirection.enable = true;

  users.groups.libvirtd.members = [ "mathias" ];

  environment.systemPackages = with pkgs; [
    virt-manager
    spice-gtk
  ];
}
