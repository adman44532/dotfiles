{
  config,
  pkgs,
  inputs,
  user,
  ...
}: {
  imports = [./hardware.nix ./keybinds.nix ./visuals.nix ./rules.nix];

  # Display Manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "Hyprland";
        user = "${user}";
      };
    };
  };

  programs.hyprland = {
    enable = true;
    # set the flake package
    package =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
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
      ### AUTOSTART ###
      #################

      exec-once = [
        "waybar"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "nm-applet"
      ];

      #################
      ###    ENV    ###
      #################
      env = [
        "XCURSOR_THEME,bibata-modern-ice"
        "XCURSOR_SIZE,24"
        "WLR_DRM_NO_MODIFIERS,1"
      ];
    };
  };
}
