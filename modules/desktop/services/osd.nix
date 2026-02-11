{
  myLib,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "osd" ["desktop"] {
    # SwayOSD for on-screen display notifications (volume, brightness, etc.)
    home-manager.users.${user}.services.swayosd.enable = true;
  }
