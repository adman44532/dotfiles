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
        (lib.mkIf (hostname == "hephaestus") {
          monitor = [
            "desc:Dell Inc. AW3423DWF 4F242S3, 3400x1440@100, 0x0, 1, bitdepth, 10, vrr, 1"
            "desc:AOC 2770 GCNG6HA016274,1920x1080@60,auto-left,1"
          ];
        })

        (lib.mkIf (hostname == "hermes") {
          monitor = [
            "eDP-1,1920x1080@360.01,0x0,1"
            ", preferred, auto, 1"
          ];
        })

        (lib.mkIf (hostname != "hephaestus" && hostname != "hermes") {
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
