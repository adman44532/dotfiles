{
  myLib,
  pkgs,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "git" ["terminal"] {
    home-manager.users.${user}.programs.git = {
      enable = true;
      package = pkgs.git.override {withLibsecret = true;};
      settings = {
        user = {
          name = "adman44532";
          email = "adman44532@gmail.com";
        };
        credential = {
          helper = "libsecret";
        };
        rerere = {
          enabled = true;
        };
        pull = {
          rebase = true;
        };
      };
    };
  }
