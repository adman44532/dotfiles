{
  pkgs,
  user,
  ...
}: {
  xdg = {
    portal = {
      enable = true;
      extraPortals = builtins.attrValues {
        inherit
          (pkgs)
          xdg-desktop-portal-gtk
          ;
      };
    };
  };

  home-manager.users.${user}.xdg = {
    mime.enable = true;

    mimeApps = {
      enable = true;
      defaultApplications = {
        "default-web-browser" = ["zen-twilight.desktop"];
        "text/html" = ["zen-twilight.desktop"];
        "x-scheme-handler/http" = ["zen-twilight.desktop"];
        "x-scheme-handler/https" = ["zen-twilight.desktop"];
        "x-scheme-handler/about" = ["zen-twilight.desktop"];
        "x-scheme-handler/unknown" = ["zen-twilight.desktop"];
      };
    };
    configFile."mimeapps.list".force = true; # Stops issue with mimeapps.list failing hm rebuilds
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "$HOME/Desktop";
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      music = "$HOME/Music";
      pictures = "$HOME/Pictures";
      videos = "$HOME/Videos";
      templates = null;
      publicShare = null;
      extraConfig = {
        XDG_PROJ_DIR = "$HOME/Projects";
        XDG_MISC_DIR = "$HOME/misc";
        XDG_PICTURES_DIR = "$HOME/Pictures";
      };
    };
  };
}
