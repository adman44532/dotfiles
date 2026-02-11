{
  myLib,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "opencode" ["development"] {
    home-manager.users.${user}.programs.opencode = {
      enable = true;
    };
  }
