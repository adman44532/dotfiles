{
  pkgs,
  user,
  yazi,
  ...
}: let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "c0ad8a3c995e2e71c471515b9cf17d68c8425fd7";
    hash = "sha256-WC/5FNzZiGxl9HKWjF+QMEJC8RXqT8WtOmjVH6kBqaY=";
  };
in {
  # TUI File Manager, Yazi
  home-manager.users.${user}.programs.yazi = {
    enable = true;
    package = yazi.packages.${pkgs.system}.default;
    enableFishIntegration = true;
    shellWrapperName = "y";

    settings = {
      plugin = {
        prepend_fetchers = [
          {
            id = "git";
            name = "*";
            run = "git";
          }
          {
            id = "git";
            name = "*/";
            run = "git";
          }
        ];
      };
    };

    plugins = {
      chmod = "${yazi-plugins}/chmod.yazi";
      mount = "${yazi-plugins}/mount.yazi";
      git = "${yazi-plugins}/git.yazi";
      smart-enter = "${yazi-plugins}/smart-enter.yazi";
      full-border = "${yazi-plugins}/full-border.yazi";
      toggle-pane = "${yazi-plugins}/toggle-pane.yazi";
      starship = pkgs.fetchFromGitHub {
        owner = "Rolv-Apneseth";
        repo = "starship.yazi";
        rev = "428d43ac0846cb1885493a1f01c049a883b70155";
        sha256 = "sha256-YkDkMC2SJIfpKrt93W/v5R3wOrYcat7QTbPrWqIKXG8=";
      };
    };

    initLua = ''
      require("full-border"):setup()
      require("starship"):setup()
      require("git"):setup()
    '';

    keymap = {
      mgr.prepend_keymap = [
        {
          on = "T";
          run = "plugin toggle-pane max-preview";
          desc = "Maximize or restore the preview pane";
        }
        {
          on = "l";
          run = "plugin smart-enter";
          desc = "Enter the child directory, or open the file";
        }
        {
          on = "M";
          run = "plugin mount";
        }
        {
          on = ["c" "m"];
          run = "plugin chmod";
          desc = "Chmod on selected files";
        }
      ];
    };
  };
}
