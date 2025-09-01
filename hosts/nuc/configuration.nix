{ config, pkgs, lib, inputs, ... }:
{
  ###############################################
  # Host: nuc (BLEPOS)
  ###############################################
  networking.hostName = "nuc";

  # Modular imports for host configuration
  imports = [
    ./hardware-configuration.nix
    ./modules/core/boot.nix
    ./modules/core/locale.nix
    ./modules/core/users.nix
    ./modules/core/nix.nix
    ./modules/network/networking.nix
    ./modules/network/firewall.nix
    ./modules/desktop/audio.nix
    ./modules/desktop/greetd-sway.nix
    ./modules/desktop/graphics.nix
    ./modules/desktop/fonts.nix
    ./modules/system/packages.nix
    ./modules/network/bluetooth.nix
    ./modules/services/services.nix
    ./modules/system/security.nix
    ./modules/core/state.nix
  ];
}
