{
  myLib,
  user,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "mako" ["desktop"] {
    environment.systemPackages = with pkgs; [
      libnotify
    ];
    # Mako notification daemon for Wayland
    home-manager.users.${user}.services.mako = {
      enable = true;
      settings = {
        defaultTimeout = 5000;
        ignoreTimeout = false;
        layer = "overlay";
        maxVisible = 5;
        sort = "-time";
      };
    };
  }
