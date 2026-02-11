{
  myLib,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "direnv" ["terminal"] {
    home-manager.users.${user}.programs.direnv = {
      enable = true;
    };
  }
