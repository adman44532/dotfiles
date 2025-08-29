{
  inputs,
  pkgs,
  user,
  ...
}: {
  environment = {
    systemPackages = [inputs.nvim-nix.packages.${pkgs.system}.default];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
  home-manager.users.${user}.home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
