{user, ...}: {
  programs.git = {
    enable = true;
    config = {
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
