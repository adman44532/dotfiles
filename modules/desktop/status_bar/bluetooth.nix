{
  pkgs,
  user,
  ...
}: {
  environment.systemPackages = with pkgs; [
    blueman
    bluez
  ];

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  home-manager.users.${user}.services.mpris-proxy.enable = true;
}
