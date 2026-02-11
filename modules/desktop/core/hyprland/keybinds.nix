{
  user,
  pkgs,
  ...
}: let
  modKey = "SUPER";
  terminal = "kitty";
  tuifileManager = "${terminal} -e yazi ~";
  guifileManager = "thunar";
  browser = "zen";
  musicPlayer = "ncspot";
  osdclient = "swayosd-client --monitor \"$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')\"";
in {
  home-manager.users.${user}.wayland.windowManager.hyprland = {
    settings = {
      bind =
        [
          # Launch Apps
          "${modKey}, return, exec, ${terminal}"
          "${modKey}, F, exec, ${tuifileManager}"
          "${modKey} SHIFT, F, exec, ${guifileManager}"
          "${modKey}, B, exec, ${browser}"
          "${modKey}, N, exec, ${terminal} -e nvim"
          "${modKey}, C, killactive"

          "${modKey}, SPACE, exec, vicinae toggle"

          # Keybind for toggling default microphone mute
          "${modKey}, M, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"

          # Control tiling
          "${modKey}, J, togglesplit"
          "${modKey}, P, pseudo"
          "${modKey}, V, togglefloating"
          "SHIFT, F11, fullscreen, 0"
          "ALT, F11, fullscreen, 1"

          # Move focus with SUPER + arrow keys
          "${modKey}, left, movefocus, l"
          "${modKey}, right, movefocus, r"
          "${modKey}, up, movefocus, u"
          "${modKey}, down, movefocus, d"

          # Switch workspaces with SUPER + [0-9]
          # Move active window to a workspace with SUPER + SHIFT + [0-9]
        ]
        ++ builtins.concatLists (builtins.genList (i: let
            ws = i + 1;
          in [
            "${modKey}, code:1${toString i}, workspace, ${toString ws}"
            "${modKey} SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ])
          10)
        ++ [
          # Tab between workspaces
          "${modKey}, TAB, workspace, e+1"
          "${modKey} SHIFT, TAB, workspace, e-1"
          "${modKey} CTRL, TAB, workspace, previous"

          # Swap active window with the one next to it with SUPER + SHIFT + arrow keys
          "${modKey} SHIFT, left, swapwindow, l"
          "${modKey} SHIFT, right, swapwindow, r"
          "${modKey} SHIFT, up, swapwindow, u"
          "${modKey} SHIFT, down, swapwindow, d"

          # Cycle through applications on active workspace
          "ALT, Tab, cyclenext"
          "ALT SHIFT, Tab, cyclenext, prev"
          "ALT, Tab, bringactivetotop"
          "ALT SHIFT, Tab, bringactivetotop"

          # Resize active window
          "${modKey}, code:20, resizeactive, -100 0"
          "${modKey}, code:21, resizeactive, 100 0"
          "${modKey} SHIFT, code:20, resizeactive, 0 -100"
          "${modKey} SHIFT, code:21, resizeactive, 0 100"

          # Scroll through existing workspaces with SUPER + scroll
          "${modKey}, mouse_down, workspace, e+1"
          "${modKey}, mouse_up, workspace, e-1"

          # Screenshots
          ", PRINT, exec, screenshot"
          "SHIFT, PRINT, exec, screenshot window"
          "CTRL, PRINT, exec, screenshot output"
          "${modKey}, PRINT, exec, pkill hyprpicker || hyprpicker -a"
        ];

      bindel = [
        # Laptop multimedia keys for volume and LCD brightness (with OSD)
        ", XF86AudioRaiseVolume, exec, ${osdclient} --output-volume raise"
        ", XF86AudioLowerVolume, exec, ${osdclient} --output-volume lower"
        ", XF86AudioMute, exec, ${osdclient} --output-volume mute-toggle"
        ", XF86AudioMicMute, exec, ${osdclient} --input-volume mute-toggle"
        ", XF86MonBrightnessUp, exec, ${osdclient} --brightness raise"
        ", XF86MonBrightnessDown, exec, ${osdclient} --brightness lower"

        # Precise 1% multimedia adjustments with Alt modifier
        "ALT, XF86AudioRaiseVolume, exec, ${osdclient} --output-volume +1"
        "ALT, XF86AudioLowerVolume, exec, ${osdclient} --output-volume -1"
        "ALT, XF86MonBrightnessUp, exec, ${osdclient} --brightness +1"
        "ALT, XF86MonBrightnessDown, exec, ${osdclient} --brightness -1"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "${modKey}, mouse:272, movewindow"
        "${modKey}, mouse:273, resizewindow"
      ];

      bindl = [
      ];
    };
  };
}
