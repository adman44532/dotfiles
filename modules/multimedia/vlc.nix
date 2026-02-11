{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "vlc" ["multimedia"] {
    environment.systemPackages = with pkgs; [vlc];
  }
