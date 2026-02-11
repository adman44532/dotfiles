{
  myLib,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "starship" ["terminal"] {
    home-manager.users.${user}.programs.starship = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
  }
