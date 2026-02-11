{
  myLib,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "greetd" ["desktop"] {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "uwsm start hyprland-uwsm.desktop";
          user = "${user}";
        };
      };
    };
  }
