{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "oculante" ["multimedia"] {
    environment.systemPackages = with pkgs; [oculante];
  }
