{
  myLib,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "zellij" ["terminal"] {
    home-manager.users.${user}.programs.zellij = {
      enable = true;
      enableFishIntegration = true;
    };
  }
