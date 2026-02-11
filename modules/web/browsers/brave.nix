{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "brave" ["web" "browsers"] {
    environment.systemPackages = with pkgs; [brave];
  }
