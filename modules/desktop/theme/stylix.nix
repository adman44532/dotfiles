{
  myLib,
  user,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
  font = {
    package = pkgs.nerd-fonts.fira-code;
    name = "FiraCode Nerd Font Mono";
  };
in
  mkModule "themes" ["desktop"] {
    programs.xfconf.enable = true;

    # Vesktop Cattpuccin Link: https://catppuccin.github.io/discord/dist/catppuccin-macchiato.theme.css

    stylix = {
      enable = true;
      image = ./wallpaper.jpg;
      polarity = "dark";

      cursor = {
        package = pkgs.phinger-cursors;
        name = "phinger-cursors-dark";
        size = 16;
      };

      fonts = {
        monospace = font;
        sansSerif = font;
        serif = font;
      };
      base16Scheme = {
        # scheme "Catppuccin Mocha";
        # author "https://github.com/catppuccin/catppuccin";
        base00 = "1e1e2e"; # base
        base01 = "181825"; # mantle
        base02 = "313244"; # surface0
        base03 = "45475a"; # surface1
        base04 = "585b70"; # surface2
        base05 = "cdd6f4"; # text
        base06 = "f5e0dc"; # rosewater
        base07 = "b4befe"; # lavender
        base08 = "f38ba8"; # red
        base09 = "fab387"; # peach
        base0A = "f9e2af"; # yellow
        base0B = "a6e3a1"; # green
        base0C = "94e2d5"; # teal
        base0D = "89b4fa"; # blue
        base0E = "cba6f7"; # mauve
        base0F = "f2cdcd"; # flamingo
      };
    };

    home-manager.users.${user} = {
      gtk.iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };

      home.packages = [
        pkgs.roboto
        pkgs.source-sans-pro
        pkgs.texlivePackages.tex-gyre
      ];
    };
  }
