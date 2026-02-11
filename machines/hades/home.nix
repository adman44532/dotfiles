{user, ...}: {
  imports = [];
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "25.05";
    packages = [];
    file = {};
    sessionVariables = {};
  };
}
