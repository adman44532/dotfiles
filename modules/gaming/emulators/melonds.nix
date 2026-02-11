{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "melonds" ["emulators" "gaming"] {
    environment.systemPackages = with pkgs; [melonDS];
  }
