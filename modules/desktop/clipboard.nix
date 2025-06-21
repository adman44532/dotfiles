{
  pkgs,
  user,
  ...
}: {
  # Cliphist to store clipboard history
  environment.systemPackages = with pkgs; [wl-clipboard-rs];
  home-manager.users.${user}.services.cliphist.enable = true;
}
