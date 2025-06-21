{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./emulators/melonds.nix
    ./gamemode.nix
    ./gamescope.nix
    ./heroic.nix
    ./mangohud.nix
    ./prismlauncher.nix
    ./steam.nix
  ];
}
