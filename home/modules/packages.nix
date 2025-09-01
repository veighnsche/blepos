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
    # Optional dev tools (uncomment as needed)
    # ollama
    # rustup
  ];
}
