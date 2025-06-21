{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./easyeffects/easyeffects.nix
    ./imv.nix
    ./pavucontrol.nix
    ./spotify.nix
    ./vlc.nix
    ./imagemagick.nix
  ];
}
