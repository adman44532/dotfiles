{
  lib,
  myLib,
  user,
  hostname,
  ...
}: {
  home-manager.users.${user}.wayland.windowManager.hyprland = {
    settings = {
      ################
      ### MONITORS ###
      ################
      monitor = lib.mkMerge [
        (lib.mkIf (hostname == "hephaestus") [
          "desc:Dell Inc. AW3423DWF 4F242S3,3400x1440@165,0x0,1"
          "desc:AOC 2770 GCNG6HA016274,1920x1080@60,auto-left,1"
        ])

        (lib.mkIf (hostname == "hermes") [
          "eDP-1,1920x1080@360.01,0x0,1"
          ", preferred, auto, 1"
        ])

        (lib.mkIf (hostname != "hephaestus" && hostname != "hermes") [
          ",preferred,auto,1"
        ])
      ];

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
