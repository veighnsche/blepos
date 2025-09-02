{ ... }:
{
  services.dbus.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  # Enable firmware update service
  services.fwupd.enable = true;
  # Enable Flatpak for user apps (Edge via Flatpak)
  services.flatpak.enable = true;
}
