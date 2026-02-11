{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "zed" ["development"] {
    environment.systemPackages = with pkgs; [zed-editor-fhs];
  }
