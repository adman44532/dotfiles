{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "keyring" ["desktop"] {
    services.gnome.gnome-keyring.enable = true;

    security.pam.services.greetd.enableGnomeKeyring = true;

    environment.systemPackages = with pkgs; [libsecret];
  }
