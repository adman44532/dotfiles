{user, ...}: {
  home-manager.users.${user}.services.network-manager-applet.enable = true;
}
