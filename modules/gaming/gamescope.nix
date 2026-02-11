{myLib, ...}: let
  inherit (myLib) mkModule;
in
  mkModule "gamescope" ["gaming"] {
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
  }
