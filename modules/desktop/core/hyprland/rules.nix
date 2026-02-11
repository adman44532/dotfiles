{
  lib,
  user,
  myLib,
  hostname,
  ...
}: {
  home-manager.users.${user}.wayland.windowManager.hyprland = {
    settings = {
      workspace = lib.mkMerge [
        ["special:scratchpad"]
        (lib.mkIf (hostname == "hephaestus") [
          "1, monitor:desc:Dell Inc. AW3423DWF 4F242S3, default:true"
        ])
        (lib.mkIf (hostname != "hephaestus") [
          "1, default:true"
        ])
      ];

      windowrule = lib.mkMerge [
        [
          # Vesktop
          "workspace 2 silent, match:class ^(vesktop)$"

          # Browsers
          "tag +chromium-based-browser, match:class ([cC]hrom(e|ium)|[bB]rave-browser|Microsoft-edge|Vivaldi-stable)"
          "tag +firefox-based-browser, match:class ([fF]irefox|zen|librewolf)"
          "tile on, match:tag chromium-based-browser"
          "tile on, match:tag firefox-based-browser"

          # Zen - float subwindows
          "float on, match:class ^(zen|zen-alpha|zen-beta)$, match:title ^Extension: "
          "float on, match:class ^(zen|zen-alpha|zen-beta)$, match:title ^Downloads "
          "float on, match:class ^(zen|zen-alpha|zen-beta)$, match:title ^(Page Info|Library|Options|Add-ons|Sync|Permissions|Certificate|Connection|Network|Browser Console|Developer Tools|Inspect|DOM Inspector|Style Editor|Responsive Design Mode|Debugger|Memory|Network Monitor|Performance|Storage Inspector|Application Panel|Web Console)"

          # Localsend
          "float on, match:class (Share|localsend)"
          "center on, match:class (Share|localsend)"

          # Pavucontrol
          "float on, match:class org.pulseaudio.pavucontrol"
          "center on, match:class pavucontrol"
          "size 800 600, match:class org.pulseaudio.pavucontrol"

          # Impala
          "float on, match:class kitty, match:title impala"
          "center on, match:class kitty, match:title impala"
          "size 800 600, match:class kitty, match:title impala"

          # Terraria
          "fullscreen on, match:class ^(steam_app_105600)$"
          "immediate on, match:class ^(steam_app_105600)$"

          # Picture-in-Picture windows
          "tag +pip, match:title ^(Picture.?in.?[Pp]icture)$"
          "float on, match:tag pip"
          "pin on, match:tag pip"
          "size 600 338, match:tag pip"
          "keep_aspect_ratio on, match:tag pip"
          "border_size 0, match:tag pip"
          "move 100%-w-40 4%, match:tag pip"

          # QEMU
          "opacity 1 1, match:class qemu"

          # RetroArch
          "fullscreen on, match:class com.libretro.RetroArch"
          "idle_inhibit fullscreen, match:class com.libretro.RetroArch"

          # Steam - tile main window, float dialogs
          "tile on, match:class steam, match:initial_title ^(Steam)$"
          "float on, match:class steam, match:title ^Friends List$"
          "size 460 800, match:class steam, match:title ^Friends List$"
          "float on, match:class steam, match:title ^(.* - )?Steam Chat$"
          "float on, match:class steam, match:title negative:^(Steam|Friends List|(.* - )?Steam Chat)$"
          "idle_inhibit fullscreen, match:class steam"

          # Steam games (generic) - fullscreen, idle inhibit, suppress resolution/fullscreen changes
          "tag +steam-game, match:class ^steam_app_"
          "fullscreen on, match:tag steam-game"
          "idle_inhibit fullscreen, match:tag steam-game"
          "suppress_event fullscreen, match:tag steam-game"

          # Floating windows
          "float on, match:tag floating-window"
          "center on, match:tag floating-window"
          "size 800 600, match:tag floating-window"
          "tag +floating-window, match:class (blueberry.py|Impala|Wiremix|org.gnome.NautilusPreviewer|com.gabm.satty|Omarchy|About|TUI.float)"
          "tag +floating-window, match:class (xdg-desktop-portal-gtk|sublime_text|DesktopEditors|org.gnome.Nautilus), match:title ^(Open.*Files?|Open [F|f]older.*|Save.*Files?|Save.*As|Save|All Files)"

          # Fullscreen screensaver
          "fullscreen on, match:class Screensaver"

          # Define terminal tag to style them uniformly
          "tag +terminal, match:class (Alacritty|kitty|com.mitchellh.ghostty)"
        ]

        # Machine-specific: pin main Steam window to primary monitor
        (lib.mkIf (hostname == "hephaestus") [
          "monitor desc:Dell Inc. AW3423DWF 4F242S3, match:class steam, match:initial_title ^(Steam)$"
        ])
        (lib.mkIf (hostname == "hermes") [
          "monitor eDP-1, match:class steam, match:initial_title ^(Steam)$"
        ])
      ];

      layerrule = [
        "no_anim on, match:namespace selection"
        "blur on, ignore_alpha 0, match:namespace vicinae"
        "no_anim on, match:namespace vicinae"
      ];
    };
  };
}
