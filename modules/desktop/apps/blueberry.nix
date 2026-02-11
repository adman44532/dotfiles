{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "blueberry" ["desktop"] {
    environment.systemPackages = with pkgs; [
      blueberry
    ];
  }
