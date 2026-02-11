{
  myLib,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "fzf" ["terminal"] {
    home-manager.users.${user}.programs.fzf = {
      enable = true;
      enableFishIntegration = true;
    };
  }
