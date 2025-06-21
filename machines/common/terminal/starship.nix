{
  config,
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user}.programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    settings = {};
  };
}
