{ config, lib, pkgs, ... }:
{
  # Manages Windsurf AppImage: installs launcher, updater service + timer.
  # To enable automatic downloads, set an environment variable with the URL:
  #   home.sessionVariables.WINDSURF_APPIMAGE_URL = "https://example.com/Windsurf-latest.AppImage";
  # The updater will fetch to: ~/.local/share/windsurf/Windsurf.AppImage

  home.packages = [ pkgs.curl pkgs.coreutils pkgs.xdg-utils ];

  xdg.desktopEntries.windsurf = {
    name = "Windsurf";
    genericName = "AI IDE";
    exec = "~/.local/bin/windsurf %U";
    icon = "windsurf"; # optional: supply via iconTheme or leave generic
    terminal = false;
    type = "Application";
    categories = [ "Development" "IDE" ];
    mimeType = [ "x-scheme-handler/windsurf" ];
  };

  home.file.".local/bin/windsurf" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail
      APPDIR="$HOME/.local/share/windsurf"
      APPIMAGE="$APPDIR/Windsurf.AppImage"
      if [ ! -x "$APPIMAGE" ]; then
        echo "Windsurf AppImage not found at $APPIMAGE" >&2
        echo "Run: systemctl --user start windsurf-update.service (after setting WINDSURF_APPIMAGE_URL)" >&2
        exit 1
      fi
      exec "$APPIMAGE" "$@"
    '';
  };

  # Service to download/update the AppImage if URL is provided
  systemd.user.services."windsurf-update" = {
    Unit = { Description = "Download/Update Windsurf AppImage"; };
    Service = {
      Type = "oneshot";
      Environment = [
        # Pass through URL if defined in sessionVariables
        ("WINDSURF_APPIMAGE_URL=" + (config.home.sessionVariables.WINDSURF_APPIMAGE_URL or ""))
      ];
      ExecStart = ''
        set -euo pipefail
        if [ -z "${WINDSURF_APPIMAGE_URL:-}" ]; then
          echo "WINDSURF_APPIMAGE_URL not set; skipping download" >&2
          exit 0
        fi
        APPDIR="$HOME/.local/share/windsurf"
        mkdir -p "$APPDIR"
        TMPFILE="$(mktemp)"
        echo "Fetching latest Windsurf from $WINDSURF_APPIMAGE_URL" >&2
        ${pkgs.curl}/bin/curl -fL "$WINDSURF_APPIMAGE_URL" -o "$TMPFILE"
        install -m 0755 "$TMPFILE" "$APPDIR/Windsurf.AppImage"
        rm -f "$TMPFILE"
      '';
    };
    Install.WantedBy = [ "default.target" ];
  };

  # Daily timer to keep it current
  systemd.user.timers."windsurf-update" = {
    Unit.Description = "Daily Windsurf AppImage updater";
    Timer = {
      OnCalendar = "daily";
      Persistent = true;
      RandomizedDelaySec = "1h";
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
