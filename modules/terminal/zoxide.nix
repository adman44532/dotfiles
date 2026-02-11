{
  myLib,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "zoxide" ["terminal"] {
    home-manager.users.${user}.programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = ["--cmd cd"];
    };
  }
