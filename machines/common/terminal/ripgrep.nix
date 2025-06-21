{
  config,
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user}.programs = {
    ripgrep = {
      enable = true;
    };
    fish.shellAliases = {grep = "rg";};
  };
}
