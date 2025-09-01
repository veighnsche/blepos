{ config, pkgs, lib, ... }:
{
  home.username = "vince";
  home.homeDirectory = "/home/vince";
  home.stateVersion = "24.05";

  # Modular imports for Home Manager
  imports = [
    ./modules/packages.nix
    ./modules/sway.nix
    ./modules/programs.nix
    ./modules/services.nix
    ./modules/git.nix
    ./modules/fonts.nix
    ./modules/waybar.nix
    ./modules/foot.nix
    ./modules/wofi.nix
  ];
}
