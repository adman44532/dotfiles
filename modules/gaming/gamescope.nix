{
  config,
  pkgs,
  ...
}: {
  # gamescopeSession option declared in steam.nix

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
}
