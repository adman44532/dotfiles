{
  pkgs,
  user,
  myLib,
  inputs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "hyprland" ["desktop"] {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # Use nixpkgs portal - flake's portal has GCC ICE build issues
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    # Provides support for X11 applications
    programs.xwayland.enable = true;
    environment.systemPackages = with pkgs; [
      xorg.xrdb
      xorg.xprop
    ];

    home-manager.users.${user}.wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        #################
        ###    ENV    ###
        #################
        env = [
          "XCURSOR_THEME,phinger-cursors-dark"
          "XCURSOR_SIZE,24"
          "WLR_DRM_NO_MODIFIERS,1"

          # Force all apps to use Wayland
          "GDK_BACKEND,wayland,x11,*"
          "QT_QPA_PLATFORM,wayland;xcb"
          "QT_STYLE_OVERRIDE,kvantum"
          "SDL_VIDEODRIVER,wayland"
          "MOZ_ENABLE_WAYLAND,1"
          "ELECTRON_OZONE_PLATFORM_HINT,wayland"
          "OZONE_PLATFORM,wayland"
        ];

        ecosystem = {
          no_update_news = true;
        };

        xwayland = {
          force_zero_scaling = true;
        };
      };
    };
  }
