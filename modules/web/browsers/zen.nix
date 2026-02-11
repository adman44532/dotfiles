{
  myLib,
  inputs,
  system,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "zen-browser" ["web"] {
    environment.systemPackages = [inputs.zen-browser.packages."${system}".twilight];
  }
