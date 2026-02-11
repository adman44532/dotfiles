{
  myLib,
  pkgs,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "latex" ["development"] {
    home-manager.users.${user} = {
      home.packages = [
        pkgs.texlivePackages.tex-gyre
      ];
    };
  }
