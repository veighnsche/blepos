{ config, lib, pkgs, ... }:
{
  # User-level Flatpak setup for Microsoft Edge with auto-updates
  # Requires system flatpak service enabled in NixOS: services.flatpak.enable = true;

  # Ensure flatpak CLI is present for user commands
  home.packages = [ pkgs.flatpak ];

  # User systemd unit to install Edge and flathub if missing
  systemd.user.services."flatpak-edge-install" = {
    Unit = {
      Description = "Ensure Flathub and Microsoft Edge are installed (user)";
      After = [ "default.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = lib.mkForce ''
        ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        ${pkgs.flatpak}/bin/flatpak install -y flathub com.microsoft.Edge || true
      '';
    };
    Install = { WantedBy = [ "default.target" ]; };
  };

  # Daily user-level flatpak update
  systemd.user.timers."flatpak-update" = {
    Unit.Description = "Daily Flatpak Update (user)";
    Timer = {
      OnCalendar = "daily";
      Persistent = true;
      RandomizedDelaySec = "1h";
    };
    Install.WantedBy = [ "timers.target" ];
  };
  systemd.user.services."flatpak-update" = {
    Unit.Description = "Run flatpak update (user)";
    Service = {
      Type = "oneshot";
      ExecStart = ''${pkgs.flatpak}/bin/flatpak update -y'';
    };
  };
}
