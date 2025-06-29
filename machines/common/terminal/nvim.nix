{
  pkgs,
  user,
  ...
}: {
  # Note: nixd is LSP for Nix files, delcare in common's default file
  environment.systemPackages = with pkgs; [lua-language-server gcc prettierd python3 fd];
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
