{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "teamspeak6-client" ["social"] {
    environment.systemPackages = with pkgs; [teamspeak6-client];
  }
