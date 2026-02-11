{
  user,
  myLib,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "eza" ["terminal"] {
    home-manager.users.${user}.programs = {
      eza = {
        enable = true;
        enableFishIntegration = true;
        icons = "always";
        git = true;
      };
      fish.shellAliases = {
        ls = "eza --icons --group-directories-first --color=always --git --time-style=long-iso --header --group";
        ll = "eza --icons --group-directories-first --color=always --git --time-style=long-iso --header --group --long";
        lt = "eza --icons --group-directories-first --color=always --git --tree --level=2";
      };
    };
  }
