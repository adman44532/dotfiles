{
  myLib,
  config,
  user,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
  colours = config.stylix.base16Scheme;
  inherit (config.stylix) fonts;

  # Terminal for TUI apps
  terminal = "${pkgs.kitty}/bin/kitty";
in
  mkModule "waybar" ["desktop"] {
    home-manager.users.${user}.programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 40;
          spacing = 0;

          modules-left = [
            "hyprland/workspaces"
          ];

          modules-center = [
            "clock"
          ];

          modules-right = [
            "tray"
            "network"
            "bluetooth"
            "pulseaudio#microphone"
            "pulseaudio"
            "battery"
          ];

          # Workspaces
          "hyprland/workspaces" = {
            on-click = "activate";
            format = "{icon}";
            format-icons = {
              default = "";
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
              "6" = "6";
              "7" = "7";
              "8" = "8";
              "9" = "9";
              active = "";
            };
            persistent-workspaces = {
              "1" = [];
              "2" = [];
              "3" = [];
              "4" = [];
              "5" = [];
            };
          };

          # Clock
          clock = {
            format = "{:%A %H:%M}";
            format-alt = "{:%d %B W%V %Y}";
            tooltip = false;
          };

          # Network
          network = {
            format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
            format = "{icon}";
            format-wifi = "{icon}";
            format-ethernet = "󰈀";
            format-disconnected = "󰤮";
            tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
            tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
            tooltip-format-disconnected = "Disconnected";
            interval = 3;
            on-click = "${terminal} -e ${pkgs.impala}/bin/impala";
          };

          # Bluetooth
          bluetooth = {
            format = "󰂯";
            format-disabled = "󰂲";
            format-connected = "󰂯 {num_connections}";
            tooltip-format = "Bluetooth: {status}";
            tooltip-format-connected = "{num_connections} connected\n{device_enumerate}";
            tooltip-format-enumerate-connected = "• {device_alias}";
            on-click = "${pkgs.blueberry}/bin/blueberry";
          };

          # Battery
          battery = {
            format = "{capacity}% {icon}";
            format-discharging = "{icon}";
            format-charging = "{icon}";
            format-plugged = "";
            format-full = "󰂅";
            format-icons = {
              charging = ["󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
              default = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            };
            tooltip-format-discharging = "{power:.1f}W↓ {capacity}%";
            tooltip-format-charging = "{power:.1f}W↑ {capacity}%";
            interval = 5;
            states = {
              warning = 20;
              critical = 10;
            };
          };

          # Audio
          pulseaudio = {
            format = "{volume}% {icon}";
            format-muted = "{volume}% 󰖁";
            format-icons = {
              default = ["" "" ""];
            };
            tooltip-format = "{desc}\nVolume: {volume}%";
            on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
            on-click-right = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_SINK@ toggle";
            scroll-step = 5;
          };

          "pulseaudio#microphone" = {
            format = "{format_source}";
            format-source = "󰍬";
            format-source-muted = "󰍭";
            on-click = "${pkgs.pavucontrol}/bin/pavucontrol -t 4";
            on-click-right = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_SOURCE@ toggle";
            tooltip-format = "{desc}\nVolume: {volume}%";
            signal = 10;
          };

          # Tray
          tray = {
            icon-size = 16;
            spacing = 8;
          };
        };
      };

      style = ''
        * {
          background-color: #${colours.base00};
          color: #${colours.base05};
          border: none;
          border-radius: 0;
          min-height: 0;
          font-family: ${fonts.monospace.name};
          font-size: 16px;
        }

        .modules-left {
          margin-left: 8px;
        }

        .modules-right {
          margin-right: 8px;
        }

        #workspaces button {
          all: initial;
          padding: 0 4px;
          margin: 0 4px;
          min-width: 8px;
        }

        #workspaces button.empty {
          opacity: 0.5;
        }

        #tray,
        #network,
        #bluetooth,
        #pulseaudio,
        #battery {
          min-width: 16px;
          padding: 0 8px;
        }

        #pulseaudio.microphone {
          min-width: 16px;
          padding: 0 8px;
        }

        #pulseaudio.microphone.source-muted {
          color: #${colours.base08};
        }

        #pulseaudio.muted {
          color: #${colours.base08};
        }

        tooltip {
          background-color: #${colours.base01};
          color: #${colours.base06};
          padding: 8px;
          font-size: 16px;
          border-radius: 8px;
          box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.5);
        }

        .hidden {
          opacity: 0;
        }
      '';
    };
  }
