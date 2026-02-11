{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "heroic" ["gaming"] {
    environment.systemPackages = with pkgs; [heroic];
  }
