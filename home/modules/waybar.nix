{ pkgs, ... }:
{
  xdg.configFile = {
    "waybar/config".text = ''
{
  "layer": "top",
  "position": "top",

  "modules-left": ["sway/workspaces"],
  "modules-center": [],
  "modules-right": ["custom/updates", "pulseaudio", "network", "clock"],

  "clock": {
    "interval": 1,
    "format": "{:%d/%m/%Y %H:%M:%S}"
  },

  "custom/updates": {
    "exec": "python3 ~/.config/waybar/scripts/updates_count.py",
    "interval": 600,
    "return-type": "json",
    "format": "{}",
    "tooltip": true,
    "on-click": "/home/vince/.config/waybar/scripts/updates_open_foot.sh"
  },

  "pulseaudio": {
    "format": "{volume}%",
    "format-muted": "muted {volume}%",
    "on-click": "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
    "on-scroll-up": "sh -c ':'",
    "on-scroll-down": "sh -c ':'"
  }
}
'';

    "waybar/style.css".text = ''
* {
    /* `otf-font-awesome` is required to be installed for icons */
    font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
    font-size: 13px;
}

window#waybar {
    background-color: rgba(43, 48, 59, 0.5);
    border-bottom: 3px solid rgba(100, 114, 125, 0.5);
    color: #ffffff;
    transition-property: background-color;
    transition-duration: .5s;
}

window#waybar.hidden {
    opacity: 0.2;
}

window#waybar.termite {
    background-color: #3F3F3F;
}

window#waybar.chromium {
    background-color: #000000;
    border: none;
}

button {
    box-shadow: inset 0 -3px transparent;
    border: none;
    border-radius: 0;
}

button:hover {
    background: inherit;
    box-shadow: inset 0 -3px #ffffff;
}

#pulseaudio:hover {
    background-color: #a37800;
}

#workspaces button {
    padding: 0 5px;
    background-color: transparent;
    color: #ffffff;
}

#workspaces button:hover {
    background: rgba(0, 0, 0, 0.2);
}

#workspaces button.focused {
    background-color: #64727D;
    border-bottom: 1px solid #666666;
}

#workspaces button.urgent {
    background-color: #eb4d4b;
}

#mode {
    background-color: #64727D;
    box-shadow: inset 0 -3px #ffffff;
}

#clock,
#battery,
#cpu,
#memory,
#disk,
#temperature,
#backlight,
#network,
#pulseaudio,
#wireplumber,
#custom-media,
#tray,
#mode,
#idle_inhibitor,
#scratchpad,
#power-profiles-daemon,
#mpd {
    padding: 0 10px;
    color: #ffffff;
}

#window,
#workspaces {
    margin: 0 4px;
}

.modules-left > widget:first-child > #workspaces {
    margin-left: 0;
}

.modules-right > widget:last-child > #workspaces {
    margin-right: 0;
}

#clock {
    background-color: #64727D;
}
'';

    "waybar/scripts/updates_count.py".text = ''
#!/usr/bin/env python3
import json
import subprocess

def get_updates_count():
    try:
        # Dry-run flake update and count bullet lines as a heuristic
        out = subprocess.check_output(
            ["bash", "-lc", "nix flake update --commit-lock-file --dry-run 2>&1 | sed -n 's/^ *• .*/•/p' | wc -l"],
            stderr=subprocess.DEVNULL
        )
        return int(out.decode().strip())
    except Exception:
        return 0

def main():
    count = get_updates_count()
    print(json.dumps({
        "text": str(count),
        "class": "updates",
        "tooltip": f"Inputs with updates: {count}"
    }))

if __name__ == "__main__":
    main()
'';

    "waybar/scripts/updates_open_foot.sh" = {
      text = ''
#!/usr/bin/env bash
set -e
FOOT_BIN=$(command -v foot || echo "foot")
"${FOOT_BIN}" -e bash -ic '~/.config/waybar/scripts/updates_prompt.sh'
'';
      executable = true;
    };

    "waybar/scripts/updates_prompt.sh" = {
      text = ''
#!/usr/bin/env bash
set -euo pipefail

echo "Previewing flake input updates (dry-run):"
nix flake update --commit-lock-file --dry-run || true
echo
read -rp "Proceed with nix flake update and commit flake.lock? [y/N] " ans || true
if [[ ${ans:-N} =~ ^[Yy]$ ]]; then
  git pull --ff-only || true
  nix flake update
  git add flake.lock || true
  git commit -m "flake: update" || true
  echo
  echo "Now you can rebuild: sudo nixos-rebuild switch --flake .#nuc"
else
  echo "Canceled"
fi
read -n1 -rp "Press any key to close..." _
'';
      executable = true;
    };
  };
}
