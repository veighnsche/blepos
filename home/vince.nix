{ config, pkgs, lib, ... }:
{
  home.username = "vince";
  home.homeDirectory = "/home/vince";
  home.stateVersion = "24.05";

  # Used by home/modules/windsurf.nix to fetch the latest AppImage
  home.sessionVariables.WINDSURF_APPIMAGE_URL = "https://windsurf-stable.codeium.com/api/update/linux-x64/stable/latest";

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
    ./modules/edge-flatpak.nix
    ./modules/windsurf.nix
  ];
}
