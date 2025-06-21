{user, ...}: {
  home-manager.users.${user}.programs.git = {
    enable = true;
    userName = "adman44532";
    userEmail = "adman44532@gmail.com";
  };
}
