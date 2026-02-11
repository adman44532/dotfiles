{
  myLib,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "yazi" ["terminal"] {
    home-manager.users.${user}.programs.yazi = {
      enable = true;
      enableFishIntegration = true;
      shellWrapperName = "y";
    };
  }
