{
  myLib,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "bat" ["terminal"] {
    home-manager.users.${user}.programs = {
      bat = {
        enable = true;
      };
      fish.shellAliases = {cat = "bat";};
    };
  }
