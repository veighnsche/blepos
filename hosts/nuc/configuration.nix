{ config, pkgs, lib, inputs, ... }:
{
  ###############################################
  # Host: nuc (BLEPOS)
  ###############################################
  networking.hostName = "nuc";

  # Modular imports for host configuration
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/locale.nix
    ./modules/users.nix
    ./modules/nix.nix
    ./modules/networking.nix
    ./modules/firewall.nix
    ./modules/audio.nix
    ./modules/greetd-sway.nix
    ./modules/graphics.nix
    ./modules/fonts.nix
    ./modules/packages.nix
    ./modules/services.nix
    ./modules/security.nix
    ./modules/state.nix
  ];
}
