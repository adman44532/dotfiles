{
  config,
  lib,
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user}.home.packages = [
    (pkgs.writeShellScriptBin "mic-status" ''
      #!/bin/bash

      # Get the ID and name of the default source (microphone)
      get_mic_info() {
          # Look for the line with default audio source (marked with *)
          local mic_line=$(wpctl status | awk '/Sources:/ {found=1} found && /^\s*│\s*\*/ && /Mono|Source/ {print; exit}')
          if [[ -n "$mic_line" ]]; then
              # Extract the ID (should be a number)
              local mic_id=$(wpctl status | awk '/Sources:/ {found=1} found && /^\s*│\s*\*/ && /Mono|Source/ {print $3; exit}' | tr -d '.')
              # Extract everything after the ID as the name
              local mic_name=$(echo "$mic_line" | awk '{$1=$2=$3=""; print $0}' | sed 's/^\s*//; s/\s*\[.*//')
              echo "$mic_id,$mic_name"
          else
              echo "error,No default source found"
          fi
      }

      # Get the current mute status of the microphone
      get_mic_status() {
          IFS=',' read -r mic_id mic_name <<< "$(get_mic_info)"

          if [[ "$mic_id" == "error" ]]; then
              echo '{"text": "", "tooltip": "Error: '"$mic_name"'", "class": "error"}'
              return
          fi

          local status=$(wpctl get-volume @DEFAULT_SOURCE@)

          if [[ $status == *"MUTED"* ]]; then
              echo '{"text": "󰍭" , "tooltip": "Device: '"$mic_name"'\nStatus: Muted", "class": "muted"}'
          else
              local volume=$(echo "$status" | awk '"'"'{print int($2 * 100)}'"'"')
              echo '{"text": "󰍬", "tooltip": "Device: '"$mic_name"'\nStatus: Active ('$volume'%)", "class": "unmuted"}'
          fi
      }

      # If script is run with toggle argument, toggle mute state
      if [[ "$1" == "toggle" ]]; then
          IFS=',' read -r mic_id mic_name <<< "$(get_mic_info)"
          if [[ "$mic_id" != "error" ]]; then
              wpctl set-mute @DEFAULT_SOURCE@ toggle
          fi
      # Otherwise output the status for waybar
      else
          get_mic_status
      fi
    '')
  ];
}
