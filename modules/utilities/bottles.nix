{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "bottles" ["utilities"] {
    environment.systemPackages = with pkgs; [bottles];
  }
