{
  config,
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user}.services.easyeffects.enable = true;
}
