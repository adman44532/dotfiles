{
  pkgs,
  user,
  ...
}: let
  modKey = "SUPER";
  terminal = "kitty";
  tuifileManager = "${terminal} -e yazi";
  guifileManager = "nemo";
  browser = "zen";
in {
  home-manager.users.${user}.wayland.windowManager.hyprland = {
    settings = {
      ###################
      ### KEYBINDINGS ###
      ###################

      bind = [
        ### Applications ###
        "${modKey}, RETURN, exec, ${terminal}"
        "${modKey}, E, exec, ${tuifileManager}"
        "${modKey}+SHIFT, E, exec, ${guifileManager}"
        "${modKey}, B, exec, ${browser}"

        ### Rofi Menus ###
        "${modKey}, SPACE, exec, pkill rofi || rofi -show drun"
        "${modKey}+CONTROL, SPACE, exec, pkill rofi || rofi -show calc"
        "${modKey}+SHIFT, SPACE, exec, rofi -modi \"emoji:${pkgs.rofimoji}/bin/rofimoji\" -show emoji" # Emojis
        "${modKey}+SHIFT, Q, exec, rofi -show power-menu -modi power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu" # Power
        "ALT, TAB, exec, rofi -show window" # App Switcher

        ### Screen Capture ###
        "${modKey}+SHIFT, P, exec, hyprpicker -an # Pick color (Hex) >> clipboard #"
        "SUPER, PRINT, exec, grimblast --freeze --notify copy area" # Region | Copy | Notify
        "SUPER+SHIFT, PRINT, exec, grimblast --freeze --notify copysave area ~/Pictures/Screenshots/screenshot-$(date '+%Y%m%d_%H%M%S').png" # Region | CopySave | Notify
        "SUPER+CTRL, PRINT, exec, grimblast --notify copy active" # Active | Copy | Notify
        "SUPER+CTRL+SHIFT, PRINT, exec, grimblast --notify copysave active ~/Pictures/Screenshots/screenshot-$(date '+%Y%m%d_%H%M%S').png" # Active | CopySave | Notify
        "SUPER+ALT, PRINT, exec, grimblast --notify copy screen" # All | Copy | Notify
        "SUPER+ALT+SHIFT, PRINT, exec, grimblast --notify copysave screen ~/Pictures/Screenshots/screenshot-$(date '+%Y%m%d_%H%M%S').png" # All | CopySave | Notify

        ### Clipboard ###
        "SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"

        #### Audio ###
        "${modKey}, M, exec, mic-status toggle"

        ### Workspaces ###

        # The Workspaces
        "${modKey}, 1, workspace, 1"
        "${modKey}, 2, workspace, 2"
        "${modKey}, 3, workspace, 3"
        "${modKey}, 4, workspace, 4"
        "${modKey}, 5, workspace, 5"
        "${modKey}, 6, workspace, 6"
        "${modKey}, 7, workspace, 7"
        "${modKey}, 8, workspace, 8"
        "${modKey}, 9, workspace, 9"
        "${modKey}, 0, workspace, 10"

        # Move Focus to workspace
        "${modKey}+SHIFT, 1, movetoworkspace, 1"
        "${modKey}+SHIFT, 2, movetoworkspace, 2"
        "${modKey}+SHIFT, 3, movetoworkspace, 3"
        "${modKey}+SHIFT, 4, movetoworkspace, 4"
        "${modKey}+SHIFT, 5, movetoworkspace, 5"
        "${modKey}+SHIFT, 6, movetoworkspace, 6"
        "${modKey}+SHIFT, 7, movetoworkspace, 7"
        "${modKey}+SHIFT, 8, movetoworkspace, 8"
        "${modKey}+SHIFT, 9, movetoworkspace, 9"
        "${modKey}+SHIFT, 0, movetoworkspace, 10"

        # Move Focus to workspace (silently)
        "${modKey}+SHIFT+CONTROL, 1, movetoworkspacesilent, 1"
        "${modKey}+SHIFT+CONTROL, 2, movetoworkspacesilent, 2"
        "${modKey}+SHIFT+CONTROL, 3, movetoworkspacesilent, 3"
        "${modKey}+SHIFT+CONTROL, 4, movetoworkspacesilent, 4"
        "${modKey}+SHIFT+CONTROL, 5, movetoworkspacesilent, 5"
        "${modKey}+SHIFT+CONTROL, 6, movetoworkspacesilent, 6"
        "${modKey}+SHIFT+CONTROL, 7, movetoworkspacesilent, 7"
        "${modKey}+SHIFT+CONTROL, 8, movetoworkspacesilent, 8"
        "${modKey}+SHIFT+CONTROL, 9, movetoworkspacesilent, 9"
        "${modKey}+SHIFT+CONTROL, 0, movetoworkspacesilent, 10"

        # Relative Navigation
        "${modKey}+CONTROL, Right, workspace, r+1"
        "${modKey}+CONTROL, Left, workspace, r-1"
        "${modKey}+CONTROL, Down, workspace, empty"

        # Move to Relative workspace
        "${modKey}+CONTROL+SHIFT, Right, movetoworkspace, r+1"
        "${modKey}+CONTROL+SHIFT, Left, movetoworkspace, r-1"

        # Scroll through workspaces
        "${modKey}, mouse_down, workspace, e-1"
        "${modKey}, mouse_up, workspace, e+1"

        ### Window Management ###
        "${modKey}, C, killactive"
        "${modKey}, F, exec, hyprctl dispatch fullscreen"
        "${modKey}+CTRL, F, togglefloating,"
        "${modKey}, G, togglegroup"

        # Changes window focus (VIM style)
        "${modKey}, H, movefocus, l" # Move focus left
        "${modKey}, J, movefocus, d" # Move focus down
        "${modKey}, K, movefocus, u" # Move focus up
        "${modKey}, L, movefocus, r" # Move focus right

        # Special workspace (scratchpad)
        "${modKey}, S, togglespecialworkspace, scratchpad"
        "${modKey}+SHIFT, S, movetoworkspace, special:scratchpad"
      ];

      binde = [
        ### Window Management ###
        # Move and Resize windows via keyboard
        "${modKey}+SHIFT, left, resizeactive, -20 0"
        "${modKey}+SHIFT, right, resizeactive, 20 0"
        "${modKey}+SHIFT, up, resizeactive, 0 -20"
        "${modKey}+SHIFT, down, resizeactive, 0 20"
      ];

      bindm = [
        ### Window Management ###
        "${modKey}, mouse:272, movewindow" # Drag Windows
        "${modKey}, mouse:273, resizewindow" # Scale Windows
      ];

      bindl = [
        # Laptop multimedia keys for volume and LCD brightness
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"

        # Requires playerctl defined in host based on keyboard.
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
    };
  };
}
