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
      ##############################
      ### WINDOWS AND WORKSPACES ###
      ##############################

      workspace = [
        "10, monitor:desc:Dell Inc. AW3423DWF 4F242S3"
        "special:scratchpad"
      ];

      windowrulev2 = [
        # XWayland fix
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

        # System dialogs and utilities
        "float, title:^(Firefox — Picture-in-Picture)$"
        "float, title:^(Picture-in-Picture)$"

        # Browser file dialogs
        "float, title:^(Save File)$"
        "size 1200 800, title:^(Save File)$"
        "center, title:^(Save File)$"

        # Additional file dialog variants
        "float, title:^(Save As|Open|File Chooser)$"
        "size 1200 800, title:^(Save As|Open|File Chooser)$"
        "center, title:^(Save As|Open|File Chooser)$"

        # Brave Browser rules
        "size 800 600, class:^(brave-browser)$, floating:1, title:^(Popup|Dialog|Brave$)"
        "center, class:^(brave-browser)$, title:^(Popup|Dialog|Brave$)"

        # PCManFM rules
        "float, class:^(pcmanfm)$, title:^(Copy|Move|Progress)$"
        "size 600 400, class:^(pcmanfm)$, title:^(Copy|Move|Progress)$"
        "center, class:^(pcmanfm)$, title:^(Copy|Move|Progress)$"

        # Steam and games
        "workspace 10 silent, class:^(steam)$" # More generic Steam class rule
        "workspace 10 silent, class:^(Steam)$"
        "workspace 10 silent, class:^(steam_app).*"
        "fullscreen, class:^(steam_app).*"
        "immediate, class:^(steam_app).*"

        # Specific game fixes
        "workspace 10 silent, title:^(Stardew Valley)$"
        "fullscreen, title:^(Stardew Valley)$"

        # File picker dialogs
        "float, title:^(Open File)$"
        "float, title:^(Select a File)$"
        "float, title:^(Choose Files)$"
        "size 1200 800, title:^(Open File|Select a File|Choose Files)$"
        "center, title:^(Open File|Select a File|Choose Files)$"

        # LibreOffice specific rules
        "float, class:^(libreoffice)$, title:^(Save As|Open|Insert|Format|Options).*$"
        "size 1200 800, class:^(libreoffice)$, title:^(Save As|Open|Insert|Format|Options).*$"
        "center, class:^(libreoffice)$, title:^(Save As|Open|Insert|Format|Options).*$"

        # Vesktop (Discord) popup that appears on launch
        "float, class:^(vesktop)$, title:^(vesktop)$"
        "size 300 350, class:^(vesktop)$, title:^(vesktop)$"
        "center, class:^(vesktop)$, title:^(vesktop)$"
        "workspace 2 silent, class:^(vesktop)$"

        # Zen Browser extension popups
        "float, class:^(zen-twilight)$, title:^(Extension:).*"
        "size 800 600, class:^(zen-twilight)$, title:^(Extension:).*"
        "center, class:^(zen-twilight)$, title:^(Extension:).*"

        # Blueman Manager as a popup
        "float, class:^(blueman-manager)$"
        "size 600 400, class:^(blueman-manager)$"
        "move 100%-600 0, class:^(blueman-manager)$"

        # Pavucontrol as a popup - fixed class name
        "float, class:^(org.pulseaudio.pavucontrol)$"
        "size 600 400, class:^(org.pulseaudio.pavucontrol)$"
        "move 100%-620 20, class:^(org.pulseaudio.pavucontrol)$"
        "pin, class:^(org.pulseaudio.pavucontrol)$"
      ];
    };
  };
}
