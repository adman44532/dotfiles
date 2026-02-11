{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "impala" ["desktop"] {
    environment.systemPackages = with pkgs; [
      impala
    ];
  }
