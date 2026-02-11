{
  myLib,
  user,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "bluetooth" [] {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    environment.systemPackages = with pkgs; [
      blueberry
    ];

    home-manager.users.${user}.services.mpris-proxy.enable = true;
  }
