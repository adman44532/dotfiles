{
  config,
  pkgs,
  user,
  ...
}: {
  environment.systemPackages = with pkgs; [libnotify];

  # Notification Daemon
  home-manager.users.${user}.services.mako = {
    enable = true;
    settings = {
      border-radius = 10;
      default-timeout = 5000;
    };
  };
}
