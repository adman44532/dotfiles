{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "prismlauncher" ["gaming"] {
    environment.systemPackages = with pkgs; [prismlauncher temurin-jre-bin];
  }
