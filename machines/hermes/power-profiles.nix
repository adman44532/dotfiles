{
  pkgs,
  user,
  ...
}: {
  # Required packages for integrated power/refresh rate management
  environment.systemPackages = with pkgs; [
    jq
    bc
    power-profiles-daemon
  ];

  # Your existing refresh rate toggle (kept for manual control)
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
          echo '{"text": "󰍹", "tooltip": "Refresh Rate: '"$current"' Hz", "class": "high-refresh"}'
        else
          echo '{"text": "󰍹", "tooltip": "Refresh Rate: '"$current"' Hz", "class": "low-refresh"}'
        fi
      fi
    '')

    # New integrated power profile script that also handles refresh rates
    (pkgs.writeShellScriptBin "power-profile-cycle" ''
      #!/usr/bin/env bash

      CURRENT=$(powerprofilesctl get)

      case "$CURRENT" in
        "performance")
          powerprofilesctl set balanced
          hyprctl keyword monitor "eDP-1,1920x1080@60,0x0,1"
          notify-send "Power Profile" "Switched to Balanced (60Hz)" -i battery-good
          ;;
        "balanced")
          powerprofilesctl set power-saver
          hyprctl keyword monitor "eDP-1,1920x1080@60,0x0,1"
          notify-send "Power Profile" "Switched to Power Saver (60Hz)" -i battery-low
          ;;
        "power-saver")
          powerprofilesctl set performance
          hyprctl keyword monitor "eDP-1,1920x1080@360.01,0x0,1"
          notify-send "Power Profile" "Switched to Performance (360Hz)" -i battery-full-charging
          ;;
      esac
    '')

    # Direct power profile setters with refresh rate control
    (pkgs.writeShellScriptBin "set-gaming-mode" ''
      #!/usr/bin/env bash
      powerprofilesctl set performance
      hyprctl keyword monitor "eDP-1,1920x1080@360.01,0x0,1"
      notify-send "Gaming Mode" "Performance + 360Hz Enabled" -i gamepad
    '')

    (pkgs.writeShellScriptBin "set-battery-mode" ''
      #!/usr/bin/env bash
      powerprofilesctl set power-saver
      hyprctl keyword monitor "eDP-1,1920x1080@60,0x0,1"
      notify-send "Battery Mode" "Power Saver + 60Hz Enabled" -i battery-low
    '')
  ];

  # Enable power management services
  services.power-profiles-daemon.enable = true;
  services.thermald.enable = true;
  powerManagement.cpuFreqGovernor = "ondemand";

  # Polkit rules for seamless power profile switching
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.UPower.Daemon" &&
            subject.isInGroup("wheel")) {
            return polkit.Result.YES;
        }
    });
  '';
}
