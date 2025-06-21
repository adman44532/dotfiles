{
  config,
  lib,
  pkgs,
  user,
  hostname,
  ...
}: {
  imports = [./custom ./nm-applet.nix ./bluetooth.nix];

  home-manager.users.${user}.programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        output = ["DP-1" "HDMI-A-1" "eDP-1"];
        modules-left = ["hyprland/workspaces"];
        modules-right = lib.mkMerge [
          (lib.mkIf (hostname == "zeus") [
            "tray"
            "custom/mic-status"
            "wireplumber"
            "clock"
            "custom/power"
          ])
          (lib.mkIf (hostname == "hermes") [
            "tray"
            "wireplumber"
            "clock"
            "custom/bluetooth"
            "custom/refresh-rate"
            "battery"
            "custom/power"
          ])
          (lib.mkIf (hostname != "zeus" && hostname != "hermes") [
            "tray"
            "wireplumber"
            "clock"
            "custom/power"
          ])
        ];
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{name}";
          format-icons = {
            "default" = "";
            "active" = "";
            "focused" = "";
            "urgent" = "";
          };
        };

        "tray" = {
          "icon-size" = 15;
          "spacing" = 10;
        };

        "custom/mic-status" = {
          "exec" = "mic-status";
          "return-type" = "json";
          "interval" = 1;
          "format" = {};
          "on-click" = "mic-status toggle";
        };

        "custom/refresh-rate" = {
          "exec" = "refresh-rate-toggle";
          "return-type" = "json";
          "interval" = 2;
          "format" = "{}";
          "on-click" = "refresh-rate-toggle toggle";
        };

        "custom/bluetooth" = {
          "exec" = "bluetooth-status";
          "return-type" = "json";
          "interval" = 5;
          "format" = "{}";
          "on-click" = "blueman-manager";
        };

        "custom/power" = {
          "format" = "";
          "on-click" = "rofi -show power-menu -modi power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu";
          "tooltip" = false;
        };

        "wireplumber" = {
          format = "{volume}% {icon}";
          format-muted = "";
          format-icons = ["" "" ""];
          on-click = "pavucontrol";
          on-click-right = "easyeffects";
        };

        "clock" = {
          "format" = "{:%H:%M}";
          "format-alt" = "{:%A, %B %d, %Y (%R)}";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          "calendar" = {
            "mode" = "year";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            "format" = {
              "months" = "<span color='${config.stylix.base16Scheme.base07}'><b>{}</b></span>";
              "days" = "<span color='${config.stylix.base16Scheme.base07}'><b>{}</b></span>";
              "weeks" = "<span color='${config.stylix.base16Scheme.base0C}'><b>W{}</b></span>";
              "weekdays" = "<span color='${config.stylix.base16Scheme.base09}'><b>{}</b></span>";
              "today" = "<span color='${config.stylix.base16Scheme.base08}'><b><u>{}</u></b></span>";
            };
          };
          "actions" = {
            "on-click-right" = "mode";
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
        };
        "battery" = {
          "bat" = "BAT1";
          "adapter" = "ADP1";
          "interval" = 60;
          "states" = {
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{capacity}% {icon}";
          "format-icons" = ["" "" "" "" ""];
          "max-length" = 25;
        };
      };
    };

    style = ''
      * {
        border: none;
        font-family: ${config.stylix.fonts.monospace.name};
        font-size: 14px;
        font-weight: 500;
        border-radius: 20px;
      }

            window#waybar {
              background: transparent;
            }
            tooltip {
              background-color: ${config.stylix.base16Scheme.base01}; /* Dark Grey */
              border: 3px solid ${config.stylix.base16Scheme.base0D};
              padding: 10px;
            }


            .modules-right {
              background-color: ${config.stylix.base16Scheme.base01}; /* Dark Grey */
              margin: 5px 5px 0 0;
              padding: 0 10px 0 10px;
            }
            .modules-left {
              background-color: ${config.stylix.base16Scheme.base01}; /* Dark Grey */
              margin: 5px 0 0 5px;
              padding: 0 10px 0 10px;
            }

            .module {
              padding: 0 10px 0 10px;
            }

            #workspaces button {
              padding: 0 0.5em;
              color: ${config.stylix.base16Scheme.base07}; /* White */
              margin: 0.25em;
              border-radius: 0px;
            }

            #workspaces button.visible {
              color: ${config.stylix.base16Scheme.base0C}; /* Side Blue */
            }

            #workspaces button.active {
              border: none;
              border-bottom: 2px solid ${config.stylix.base16Scheme.base0D};
              color: ${config.stylix.base16Scheme.base0D}; /* Primary Blue */
            }

            #workspaces button.urgent {
              background-color: ${config.stylix.base16Scheme.base08}; /* Red */
              border-radius: 1em;
              color: ${config.stylix.base16Scheme.base07}; /* White */
            }


            #clock,
            #battery,
            #network,
            #wireplumber,
            #tray,
            #custom-power {
              padding: 0 10px;
            }
            #custom-power {
              border-radius: 100px;
              margin: 5px 5px;
              padding: 1px 1px 1px 6px;
              min-width: 15px
            }


            #custom-mic-status {
              transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1), opacity 0.5s ease, transform 0.3s ease-out;
            }
            #custom-mic-status.muted {
              color: ${config.stylix.base16Scheme.base08};
            }
            #custom-mic-status.unmuted {
              color:rgb(245, 245, 245); /* White */
            }


            #battery.charging {
              color: #2dcc36;
            }
            #battery.warning:not(.charging) {
              color: #e6e600;
            }
            #battery.critical:not(.charging) {
              color: ${config.stylix.base16Scheme.base08};
            }
            #temperature.critical {
              color: ${config.stylix.base16Scheme.base08};
            }

            #custom-bluetooth.bt-off {
        color: gray;
      }

      #custom-bluetooth.bt-on {
        color: blue;
      }

      #custom-bluetooth.bt-connected {
        color: limegreen;
      }

    '';
  };
}
