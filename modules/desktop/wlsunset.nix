{
  user,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    wlsunset
  ];
  # Nighttime colour temp
  home-manager.users.${user} = {
    systemd.user.services.wlsunset = {
      Unit = {
        Description = "wlsunset | Blue Light Filter";
        After = ["graphical-session.target"];
      };
      Service = {
        ExecStart = "${pkgs.wlsunset}/bin/wlsunset -t 6500 -T 2600 -s 20:00 -S 05:30 -d 1800";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = ["default.target"];
      };
    };
  };
}
