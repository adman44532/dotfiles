{
  myLib,
  inputs,
  pkgs,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "nvim" ["terminal"] {
    environment = {
      systemPackages = [inputs.nvim-nix.packages.${pkgs.system}.default];
      variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    };
    home-manager.users.${user}.home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  }
