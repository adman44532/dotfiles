{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hyprland
    ./status_bar/waybar.nix
    ./themes
    ./app_launcher
    ./external_devices.nix
    ./screenshots.nix
    ./audio.nix
    ./clipboard.nix
    ./notifications.nix
    ./screenshots.nix
    ./terminal.nix
    ./wlsunset.nix
    ./nemo.nix
  ];
}
