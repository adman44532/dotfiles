{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "unarchivers" ["utilities"] {
    environment.systemPackages = with pkgs; [
      zip
      unzip
      p7zip
      unrar
    ];
  }
