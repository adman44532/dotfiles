{
  myLib,
  pkgs,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "thunar" ["desktop"] {
    # System-level: Services Thunar needs
    services.udisks2.enable = true;
    services.gvfs.enable = true;

    programs.thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
        thunar-media-tags-plugin
        thunar-vcs-plugin
      ];
    };
  }
