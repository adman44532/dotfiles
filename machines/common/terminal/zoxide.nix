{
  config,
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user}.programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = ["--cmd cd"];
  };
}
