{
  config,
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user}.programs.gitui = {enable = true;};
}
