{
  pkgs,
  user,
  ...
}: {
  environment.systemPackages = with pkgs; [lua-language-server];
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
