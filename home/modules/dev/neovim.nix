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

  # Wire the repo-managed Neovim config
  # Place your Neovim files under: home/dotfiles/nvim/
  xdg.configFile."nvim".source = ../../dotfiles/nvim;
}
