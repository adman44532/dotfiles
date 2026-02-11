{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "obsidian" ["utilities"] {
    environment.systemPackages = with pkgs; [obsidian];
  }
