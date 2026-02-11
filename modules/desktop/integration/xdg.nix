{
  myLib,
  pkgs,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "xdg" ["desktop"] {
    xdg = {
      portal = {
        enable = true;
        extraPortals = builtins.attrValues {
          inherit (pkgs) xdg-desktop-portal-gtk;
        };
        xdgOpenUsePortal = true;
        config = {
          common = {
            default = ["*"];
            "org.freedesktop.impl.portal.ScreenCast" = ["hyprland"];
            "org.freedesktop.impl.portal.GlobalShortcuts" = ["hyprland"];
          };
        };
      };
    };
    home-manager.users.${user}.xdg = {
      mime.enable = true;
      mimeApps = {
        enable = true;
        defaultApplications = {
          # Web Browser
          "default-web-browser" = ["zen-twilight.desktop"];
          "text/html" = ["zen-twilight.desktop"];
          "x-scheme-handler/http" = ["zen-twilight.desktop"];
          "x-scheme-handler/https" = ["zen-twilight.desktop"];
          "x-scheme-handler/about" = ["zen-twilight.desktop"];
          "x-scheme-handler/unknown" = ["zen-twilight.desktop"];

          # File Manager
          "inode/directory" = ["thunar.desktop"];

          # Images
          "image/png" = ["oculante.desktop"];
          "image/jpeg" = ["oculante.desktop"];
          "image/jpg" = ["oculante.desktop"];
          "image/gif" = ["oculante.desktop"];
          "image/svg+xml" = ["oculante.desktop"];
          "image/webp" = ["oculante.desktop"];
          "image/bmp" = ["oculante.desktop"];
          "image/tiff" = ["oculante.desktop"];

          # Videos
          "video/mp4" = ["mpv.desktop"];
          "video/x-matroska" = ["mpv.desktop"];
          "video/webm" = ["mpv.desktop"];
          "video/mpeg" = ["mpv.desktop"];
          "video/x-msvideo" = ["mpv.desktop"];
          "video/quicktime" = ["mpv.desktop"];

          # Audio
          "audio/mpeg" = ["mpv.desktop"];
          "audio/mp3" = ["mpv.desktop"];
          "audio/flac" = ["mpv.desktop"];
          "audio/x-wav" = ["mpv.desktop"];
          "audio/ogg" = ["mpv.desktop"];
          "audio/x-vorbis+ogg" = ["mpv.desktop"];
          "audio/aac" = ["mpv.desktop"];

          # Documents
          "application/pdf" = ["zen-twilight.desktop"];

          # LibreOffice - Word Documents
          "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = ["writer.desktop"]; # .docx
          "application/msword" = ["writer.desktop"]; # .doc
          "application/vnd.oasis.opendocument.text" = ["writer.desktop"]; # .odt
          "application/rtf" = ["writer.desktop"];

          # LibreOffice - Spreadsheets
          "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = ["calc.desktop"]; # .xlsx
          "application/vnd.ms-excel" = ["calc.desktop"]; # .xls
          "application/vnd.oasis.opendocument.spreadsheet" = ["calc.desktop"]; # .ods

          # LibreOffice - Presentations
          "application/vnd.openxmlformats-officedocument.presentationml.presentation" = ["impress.desktop"]; # .pptx
          "application/vnd.ms-powerpoint" = ["impress.desktop"]; # .ppt
          "application/vnd.oasis.opendocument.presentation" = ["impress.desktop"]; # .odp

          # Text files
          "text/plain" = ["nvim.desktop"];
          "text/markdown" = ["nvim.desktop"];
          "text/x-readme" = ["nvim.desktop"];

          # Code files
          "text/x-python" = ["nvim.desktop"];
          "text/x-shellscript" = ["nvim.desktop"];
          "text/x-csrc" = ["nvim.desktop"];
          "text/x-c++src" = ["nvim.desktop"];
          "text/x-rust" = ["nvim.desktop"];
          "application/json" = ["nvim.desktop"];
          "application/xml" = ["nvim.desktop"];
          "text/x-nix" = ["nvim.desktop"];

          # Archives
          "application/zip" = ["thunar.desktop"];
          "application/x-tar" = ["thunar.desktop"];
          "application/x-compressed-tar" = ["thunar.desktop"];
          "application/x-7z-compressed" = ["thunar.desktop"];
          "application/x-rar" = ["thunar.desktop"];
          "application/gzip" = ["thunar.desktop"];
          "application/x-bzip" = ["thunar.desktop"];
        };
      };
      configFile."mimeapps.list".force = true;
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
