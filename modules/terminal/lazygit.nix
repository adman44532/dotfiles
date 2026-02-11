{
  myLib,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "lazygit" ["terminal"] {
    home-manager.users.${user}.programs.lazygit.enable = true;
  }
