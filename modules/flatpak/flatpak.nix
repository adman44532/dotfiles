{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "flatpak" [] {
    services.flatpak = {
      enable = true;
      update = {
        onActivation = true;
      };
      uninstallUnmanaged = false;
    };
    environment.systemPackages = with pkgs; [
      glib # provides gio
    ];
  }
