{
  myLib,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "ripgrep" ["terminal"] {
    home-manager.users.${user}.programs = {
      ripgrep.enable = true;
      fish.shellAliases = {grep = "rg";};
    };
  }
