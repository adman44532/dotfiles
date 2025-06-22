{
  config,
  pkgs,
  user,
  ...
}: {
  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "25.05";

  imports = [];

  home.packages = [];

  home.file = {};

  home.sessionVariables = {};
}
