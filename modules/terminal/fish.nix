{
  myLib,
  user,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "fish" ["terminal"] {
    environment.systemPackages = with pkgs; [fish bash];
    programs.fish = {
      enable = true;
      shellAliases = {}; # Globals
    };

    users.defaultUserShell = pkgs.fish;

    home-manager.users.${user} = {
      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting
          fish_vi_key_bindings
        '';
        shellAliases = {};
      };
    };
  }
