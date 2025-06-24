{
  pkgs,
  user,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };
  home-manager.users.${user}.home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
