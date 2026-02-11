{
  user,
  myLib,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "btop" ["terminal"] {
    home-manager.users.${user}.programs.btop.enable = true;
  }
