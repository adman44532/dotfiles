{
  config,
  lib,
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user}.home.packages = [
    (pkgs.writeShellScriptBin "power-profile-status" ''
            #!/bin/bash

      PROFILE=$(powerprofilesctl get 2>/dev/null || echo "unknown")
      REFRESH_RATE=$(hyprctl monitors -j | jq -r '.[] | select(.name == "eDP-1") | .refreshRate' 2>/dev/null || echo "0")

      case "$PROFILE" in
        "performance")
          ICON="󱓞"
          TEXT="Performance"
          CLASS="performance"
          EXPECTED_REFRESH="360Hz"
          ;;
        "balanced")
          ICON=""
          TEXT="Balanced"
          CLASS="balanced"
          EXPECTED_REFRESH="60Hz"
          ;;
        "power-saver")
          ICON=""
          TEXT="Power Saver"
          CLASS="power-saver"
          EXPECTED_REFRESH="60Hz"
          ;;
        *)
          ICON=""
          TEXT="Unknown"
          CLASS="unknown"
          EXPECTED_REFRESH="Unknown"
          ;;
      esac

      # Format refresh rate for display
      if (( $(echo "$REFRESH_RATE > 100" | bc -l) )); then
        REFRESH_DISPLAY="360Hz"
      else
        REFRESH_DISPLAY="60Hz"
      fi

      # Output JSON for waybar with refresh rate info
      echo "{\"text\":\"$ICON\",\"tooltip\":\"Power Profile: $TEXT\\nRefresh Rate: $REFRESH_DISPLAY\\nClick to cycle profiles\",\"class\":\"$CLASS\"}"
    '')
  ];
}
