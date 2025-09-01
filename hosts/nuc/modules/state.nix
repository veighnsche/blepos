{ lib, ... }:
{
  systemd.defaultUnit = "graphical.target";
  system.stateVersion = lib.mkDefault "24.05";
}
