{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "imagemagick" ["multimedia"] {
    environment.systemPackages = with pkgs; [imagemagick];
  }
