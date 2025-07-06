{
  user,
  hostname,
  lib,
  ...
}: {
  home-manager.users.${user}.programs.zellij = {
    enable = true;
    enableFishIntegration = lib.mkIf (hostname != "hades") true;
  };
}
