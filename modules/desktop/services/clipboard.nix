{
  myLib,
  pkgs,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "clipboard" ["desktop"] {
    # Cliphist to store clipboard history
    environment.systemPackages = with pkgs; [
      wl-clipboard-rs
      wl-clipboard
      wl-clip-persist
    ];
    home-manager.users.${user} = {
      services.cliphist.enable = true;
      systemd.user.services.wl-clip-persist = {
        Unit = {
          Description = "Persist Wayland clipboard content";
          After = ["graphical-session.target"];
          PartOf = ["graphical-session.target"];
        };
        Service = {
          ExecStart = "${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard regular --all-mime-type-regex '(?i)^(?!image/).+'";
          Restart = "always";
        };
        Install.WantedBy = ["graphical-session.target"];
      };
    };
  }
