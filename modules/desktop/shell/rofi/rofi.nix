{
  lib,
  myLib,
  pkgs,
  user,
  hostname,
  ...
}: let
  inherit (myLib) mkModule;

  power-profile-menu = pkgs.writeShellScriptBin "rofi-power-profile-menu" ''
    # Get current power profile
    CURRENT=$(powerprofilesctl get)

    # Define menu options with icons
    OPTIONS="󰓅 Performance (360Hz)\n󰾅 Balanced (60Hz)\n󰾆 Power Saver (60Hz)"

    # Show rofi menu and get selection
    CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Power Profile" -theme-str 'window {width: 400px;}')

    case "$CHOICE" in
      "󰓅 Performance (360Hz)")
        powerprofilesctl set performance
        hyprctl keyword monitor "eDP-1,1920x1080@360.01,0x0,1"
        notify-send "Power Profile" "Performance + 360Hz Enabled" -i battery-full-charging
        ;;
      "󰾅 Balanced (60Hz)")
        powerprofilesctl set balanced
        hyprctl keyword monitor "eDP-1,1920x1080@60,0x0,1"
        notify-send "Power Profile" "Balanced + 60Hz Enabled" -i battery-good
        ;;
      "󰾆 Power Saver (60Hz)")
        powerprofilesctl set power-saver
        hyprctl keyword monitor "eDP-1,1920x1080@60,0x0,1"
        notify-send "Power Profile" "Power Saver + 60Hz Enabled" -i battery-low
        ;;
      *)
        exit 0
        ;;
    esac
  '';
in
  mkModule "rofi" ["desktop"] {
    home-manager.users.${user} = {config, ...}: {
      home.packages = with pkgs;
        [
          rofi-power-menu
          rofimoji
          rofi-calc
        ]
        ++ lib.optional (hostname == "hermes") power-profile-menu;

      programs.rofi = {
        enable = true;

        cycle = false;
        terminal = "${pkgs.kitty}/bin/kitty";
        location = "center";

        plugins = builtins.attrValues {
          inherit (pkgs) rofimoji rofi-power-menu rofi-calc;
        };

        theme = lib.mkForce ./theme.rasi;
      };
    };
  }
