{
  config,
  pkgs,
  user,
  ...
}: {
  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "24.11";

  imports = [];

  home.packages = [];

  home.file = {};

  home.sessionVariables = {};
}
