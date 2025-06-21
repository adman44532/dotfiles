{
  lib,
  user,
  hostname,
  ...
}: let
  terminal = "kitty";
  modKey = "SUPER";
in {
  home-manager.users.${user}.wayland.windowManager.hyprland = {
    settings = {
      ################
      ### MONITORS ###
      ################
      monitor = lib.mkMerge [
        (lib.mkIf (hostname == "zeus") {
          monitor = [
            "DP-1,3440x1440@60,0x0,1"
            "HDMI-A-1,1920x1080@60.00,auto-left,1"
          ];
        })

        (lib.mkIf (hostname == "hermes") {
          monitor = [
            "eDP-1,1920x1080@360.01,0x0,1"
          ];
        })

        (lib.mkIf (hostname != "zeus" && hostname != "hermes") {
          monitor = [
            ",preferred,auto,1"
          ];
        })
      ];

      # Workspaces found in windowrules.nix

      ################
      ###   INPUT  ###
      ################
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        accel_profile = "flat";

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          tap-to-click = false;
        };
      };
    };
  };
}
