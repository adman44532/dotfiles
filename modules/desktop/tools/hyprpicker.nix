{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "hyprpicker" ["desktop"] {
    environment.systemPackages = with pkgs; [
      hyprpicker
    ];
  }
