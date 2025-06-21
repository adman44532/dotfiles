{user, ...}: {
  home-manager.users.${user}.programs = {
    ghostty = {
      enable = true;
      enableFishIntegration = true;
      installVimSyntax = true;
      installBatSyntax = true;
    };
    # Add Kitty as an alternative incase Hyprland fails
    kitty = {
      enable = true;
      enableGitIntegration = true;
      shellIntegration.enableFishIntegration = true;
    };
  };
}
