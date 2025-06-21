{
  config,
  pkgs,
  user,
  ...
}: {
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
  };
}
