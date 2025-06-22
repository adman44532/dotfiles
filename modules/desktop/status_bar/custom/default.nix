{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [./mic-status.nix ./bluetooth-status.nix ./power-profile-status.nix];
}
