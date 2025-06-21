{
  pkgs,
  user,
  ...
}: {
  # I was a bit lazy and didn't want to handle the awk grep sed sorta way
  environment.systemPackages = with pkgs; [
    jq
    bc
  ];
  home-manager.users.${user}.home.packages = [
    (pkgs.writeShellScriptBin "refresh-rate-toggle" ''
      #!/usr/bin/env bash

      # Detect current refresh rate of eDP-1
      current=$(hyprctl monitors -j | jq -r '.[] | select(.name == "eDP-1") | .refreshRate')

      if [[ "$1" == "toggle" ]]; then
        if (( $(echo "$current > 100" | bc -l) )); then
          hyprctl keyword monitor "eDP-1,1920x1080@60,0x0,1"
        else
          hyprctl keyword monitor "eDP-1,1920x1080@360.01,0x0,1"
        fi
      else
        if (( $(echo "$current > 100" | bc -l) )); then
          echo '{"text": "󰍹", "tooltip": "Refresh Rate: '"$current"' Hz", "class": "high-refresh"}'
        else
          echo '{"text": "󰍹", "tooltip": "Refresh Rate: '"$current"' Hz", "class": "low-refresh"}'
        fi
      fi
    '')
  ];
}
