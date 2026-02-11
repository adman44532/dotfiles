{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "pavucontrol" ["multimedia"] {
    environment.systemPackages = with pkgs; [pavucontrol];
  }
