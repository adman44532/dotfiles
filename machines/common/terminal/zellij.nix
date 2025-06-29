{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user}.programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "cattpuccin_macchiato";
    };
  };
}
