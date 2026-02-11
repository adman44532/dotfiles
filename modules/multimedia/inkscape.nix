{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "inkscape" ["multimedia"] {
    environment.systemPackages = with pkgs; [inkscape];
  }
