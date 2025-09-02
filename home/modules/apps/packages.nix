{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Wayland/Sway stack
    swaybg swayidle swaylock-effects waybar wofi
    mako
    # Terminal
    foot
    # Ensure python for Waybar scripts
    python3
    # Wayland helpers
    slurp
    wev
    # Utilities / apps
    mpv
    pavucontrol
    geany
    qdirstat
    lxappearance
    # File manager and plugins
    nemo
    nemo-fileroller
    nemo-preview
    nemo-share
    # Icon theme
    papirus-icon-theme
    # Sysinfo/cli tools
    fastfetch
    inxi
    lshw
    hwinfo
    # Dev tools
    bun
    pnpm
    # Optional dev tools (uncomment as needed)
    # ollama
    # rustup
    # From AUR list (unfree or not in nixpkgs) — uncomment if configured elsewhere:
    # chatgpt-cli            # not in nixpkgs (consider pipx or a wrapper)
    # windsurf               # see home/modules/windsurf.nix for packaging via AppImage
  ];
}
