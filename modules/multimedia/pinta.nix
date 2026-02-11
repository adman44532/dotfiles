{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "pinta" ["multimedia"] {
    environment.systemPackages = with pkgs; [pinta];
  }
