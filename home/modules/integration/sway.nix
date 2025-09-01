{ config, lib, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures = { gtk = true; };
    config = {
      modifier = "Mod4";
      terminal = "foot";
      menu = "wofi --show drun";
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
