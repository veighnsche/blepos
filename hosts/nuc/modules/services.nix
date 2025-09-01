{ ... }:
{
  services.dbus.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  # From Arch inventory: fwupd installed -> enable service
  services.fwupd.enable = true;
  # Enable Flatpak for user apps (Edge via Flatpak)
  services.flatpak.enable = true;
}
