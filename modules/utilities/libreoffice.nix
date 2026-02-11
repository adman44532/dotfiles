{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "libreoffice" ["utilities"] {
    environment.systemPackages = with pkgs; [libreoffice-qt6-fresh];
  }
