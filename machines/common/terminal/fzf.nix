{
  config,
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user}.programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };
}
