{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [./mic-status.nix ./laptop-refresh-rate.nix ./bluetooth-status.nix];
}
