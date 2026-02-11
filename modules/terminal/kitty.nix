{
  user,
  myLib,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "kitty" ["desktop" "terminal"] {
    home-manager.users.${user}.programs.kitty = {
      enable = true;
      enableGitIntegration = true;
      shellIntegration.enableFishIntegration = true;
    };
  }
