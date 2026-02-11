{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "vesktop" ["social"] {
    environment.systemPackages = with pkgs; [vesktop];
  }
