{
  myLib,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "easyeffects" ["multimedia"] {
    home-manager.users.${user}.services.easyeffects.enable = true;
  }
