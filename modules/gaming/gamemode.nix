{myLib, ...}: let
  inherit (myLib) mkModule;
in
  mkModule "gamemode" ["gaming"] {
    # Enable Gamemode to improve gaming performance
    programs.gamemode.enable = true;
  }
