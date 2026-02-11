{
  lib,
  myLib,
  ...
}: {
  services.flatpak.remotes = lib.mkOptionDefault [
    # Example for future use:
    # { name = "flathub-beta"; location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo"; }
  ];
}
