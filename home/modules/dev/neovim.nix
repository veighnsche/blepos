{ config, pkgs, lib, ... }:
{
  # Core Neovim setup managed by Home Manager
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Useful CLI tools Neovim/Telescope commonly expects
  home.packages = with pkgs; [
    ripgrep
    fd
    unzip
  ];
}
