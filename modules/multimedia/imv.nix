{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [imv];
}
