{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "localsend" ["utilities"] {
    environment.systemPackages = with pkgs; [localsend];
    programs.localsend.enable = true;
    programs.localsend.openFirewall = true;
  }
