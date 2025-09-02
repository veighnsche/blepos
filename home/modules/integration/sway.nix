{ config, lib, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures = { gtk = true; };
    config = {
      modifier = "Mod4";
      terminal = "foot";
      menu = "wofi --show drun";
      # Outputs
      output = {
        # Screen 1: OMEN 2K (bottom-left)
        "HDMI-A-1" = {
          mode = "2560x1440";
          position = "0 1080";
        };

        # Screen 3: LG Ultra HD 4K (bottom-right)
        "DP-1" = {
          mode = "3840x2160";
          position = "2560 1080";
          scale = 1.67;
        };

        # Screen 2: LG IPS FullHD (top-right, above the 4K)
        "HDMI-A-2" = {
          mode = "1920x1080";
          position = "2560 0";
        };
      };

      # Workspace to output mapping
      workspaceOutputAssign = [
        { workspace = "1"; output = "HDMI-A-1"; }
        { workspace = "2"; output = "HDMI-A-2"; }
        { workspace = "3"; output = "DP-1"; }
      ];

      keybindings = lib.mkOptionDefault {
        "${config.wayland.windowManager.sway.config.modifier}+Return" = "exec foot";
        "${config.wayland.windowManager.sway.config.modifier}+Shift+e" = "exec swaymsg exit";
      };
      startup = [
        { command = "waybar"; always = true; }
        { command = "mako"; always = true; }
        { command = "swaybg -i ~/.wallpaper --mode fill"; always = true; }
        { command = ''
            swayidle -w \
              timeout 300 'swaylock-effects -f --screenshots --effect-blur 7x5' \
              timeout 600 'swaymsg "output * dpms off"' \
              resume 'swaymsg "output * dpms on"' \
              before-sleep 'swaylock-effects -f --screenshots --effect-blur 7x5'
        '';
        }
      ];
    };
  };
}
