{ config, pkgs, lib, ... }:
{
  home.username = "vince";
  home.homeDirectory = "/home/vince";
  home.stateVersion = "24.05";

  # Used by home/modules/windsurf.nix to fetch the latest AppImage
  home.sessionVariables.WINDSURF_APPIMAGE_URL = "https://windsurf-stable.codeium.com/api/update/linux-x64/stable/latest";

  # Modular imports for Home Manager
  imports = [
    ./modules/apps/packages.nix
    ./modules/integration/sway.nix
    ./modules/apps/programs.nix
    ./modules/integration/services.nix
    ./modules/dev/git.nix
    ./modules/integration/fonts.nix
    ./modules/apps/waybar.nix
    ./modules/apps/foot.nix
    ./modules/apps/wofi.nix
    ./modules/integration/edge-flatpak.nix
    ./modules/dev/neovim.nix
    ./modules/dev/windsurf.nix
  ];
}
