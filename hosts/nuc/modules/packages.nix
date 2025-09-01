{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git curl wget unzip ripgrep eza htop btop fastfetch
    wl-clipboard grim slurp
    nemo
    neovim
    firefox
    microsoft-edge
  ];
}
