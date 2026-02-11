{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "parsec" ["gaming"] {
    environment.systemPackages = with pkgs; [parsec-bin];
  }
