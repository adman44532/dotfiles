{user, ...}: {
  home-manager.users.${user}.programs.git = {
    enable = true;
    extraConfig = {
      user = {
        name = "adman44532";
        email = "adman44532@gmail.com";
      };
      rerere = {
        enabled = true;
      };
      pull = {
        rebase = true;
      };
    };
  };
}
