{
  pkgs,
  lib,
  inputs,
  user,
  ...
}: let
  terminal = "kitty";
  modKey = "SUPER";
in {
  home-manager.users.${user}.wayland.windowManager.hyprland = {
    settings = {
      #####################
      ### LOOK AND FEEL ###
      #####################

      # Refer to https://wiki.hyprland.org/Configuring/Variables/

      # https://wiki.hyprland.org/Configuring/Variables/#general
      general = {
        "gaps_in" = "5";
        "gaps_out" = "5";
        "border_size" = "3";
        "resize_on_border" = "true";
        "layout" = "dwindle";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#decoration
      decoration = {
        rounding = "10";

        shadow = {
          enabled = "true";
        };
      };

      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations = {
        enabled = true;
        # Defining smooth bezier curves for different animation types
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "overshot,0.05,0.9,0.1,1.05" # Slightly reduced overshoot for consistency
          "smoothOut,0.36,0,0.66,-0.56"
          "smoothIn,0.25,1,0.5,1"
          "bounce,1,1.6,0.1,0.85"
          "winIn,0.1,1.1,0.1,1.1"
          "winOut,0.3,0,0.2,1"
          "linear,0,0,1,1"
          "popIn,0.12,0.95,0.5,1.05"
          "popOut,0.5,0,0.2,0.9" # New curve for pop-out effect
        ];

        animation = [
          "windows, 1, 4, overshot, slide"
          "windowsOut, 1, 3, popOut, popin 60%"
          "windowsMove, 1, 3.5, overshot"

          "windowsIn, 1, 4, popIn, popin 80%"
          "border, 1, 8, default"
          "borderangle, 1, 6, linear, loop"

          "fade, 1, 3, smoothIn"
          "fadeDim, 1, 2, smoothIn"

          "workspaces, 1, 4, overshot, slidevert"
          "specialWorkspace, 1, 4, overshot, slidevert"

          "layers, 1, 3, smoothIn, fade"
          "layersIn, 1, 3, popIn, fade"
          "layersOut, 1, 2.5, smoothOut, fade"
        ];
      };

      dwindle = {
        pseudotile = true;
        smart_split = true;
        smart_resizing = true;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        animate_manual_resizes = true;
      };
    };
  };
}
