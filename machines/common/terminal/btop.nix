{
  config,
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user}.programs.btop = {enable = true;};
}
