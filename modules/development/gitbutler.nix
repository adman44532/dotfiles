{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "gitbutler" ["development"] {
    environment.systemPackages = with pkgs; [
      gitbutler
    ];
  }
