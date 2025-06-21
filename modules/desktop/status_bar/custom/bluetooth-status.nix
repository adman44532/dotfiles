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
    (pkgs.writeShellScriptBin "bluetooth-status" ''
      #!/usr/bin/env bash

      # Get Bluetooth powered status and connected devices info using Bluetoothctl
      powered=$(bluetoothctl show | jq -r 'select(.powered == "yes")')
      connected_devices=$(bluetoothctl devices | jq -r '.[] | select(.Connected == true) | .Name')

      # Generate JSON output for Waybar
      if [[ -n "$powered" ]]; then
        if [[ -n "$connected_devices" ]]; then
          # Bluetooth is on, with connected devices → green icon
          echo '{"text": "", "class": "bt-connected", "tooltip": "'"$connected_devices"'"}'
        else
          # Bluetooth is on, but no devices connected → blue icon
          echo '{"text": "", "class": "bt-on", "tooltip": "Bluetooth is on"}'
        fi
      else
        # Bluetooth is off → gray icon
        echo '{"text": "", "class": "bt-off", "tooltip": "Bluetooth is off"}'
      fi

    '')
  ];
}
