{
  pkgs,
  user,
  ...
}: {
  programs.xfconf.enable = true;

  # Vesktop Cattpuccin Link: https://catppuccin.github.io/discord/dist/catppuccin-macchiato.theme.css

  stylix = {
    enable = true;
    image = ./wallpaper.jpg;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font"; # Correct name
      };

      sansSerif = {
        package = pkgs.nerd-fonts.noto;
        name = "Noto Nerd Font";
      };

      serif = {
        package = pkgs.nerd-fonts.noto;
        name = "Noto Nerd Font";
      };

      emoji = {
        package = pkgs.twemoji-color-font;
        name = "Twitter Color Emoji";
      };
    };
    # base16Scheme = {
    #   base00 = "#171B24";
    #   base01 = "#1F2430";
    #   base02 = "#242936";
    #   base03 = "#707A8C";
    #   base04 = "#8A9199";
    #   base05 = "#CCCAC2";
    #   base06 = "#D9D7CE";
    #   base07 = "#F3F4F5";
    #   base08 = "#F28779";
    #   base09 = "#FFAD66";
    #   base0A = "#FFD173";
    #   base0B = "#D5FF80";
    #   base0C = "#95E6CB";
    #   base0D = "#5CCFE6";
    #   base0E = "#D4BFFF";
    #   base0F = "#F29E74";
    # };
    base16Scheme = {
      base00 = "#24273a"; # base
      base01 = "#1e2030"; # mantle
      base02 = "#363a4f"; # surface0
      base03 = "#494d64"; # surface1
      base04 = "#5b6078"; # surface2
      base05 = "#cad3f5"; # text
      base06 = "#f4dbd6"; # rosewater
      base07 = "#b7bdf8"; # lavender
      base08 = "#ed8796"; # red
      base09 = "#f5a97f"; # peach
      base0A = "#eed49f"; # yellow
      base0B = "#a6da95"; # green
      base0C = "#8bd5ca"; # teal
      base0D = "#8aadf4"; # blue
      base0E = "#c6a0f6"; # mauve
      base0F = "#f0c6c6"; # flamingo
    };
  };

  home-manager.users.${user} = {
    fonts.fontconfig.enable = true;

    gtk.iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela";
    };

    home.packages = [
      pkgs.roboto
      pkgs.source-sans-pro
      pkgs.texlivePackages.tex-gyre
    ];
  };
}
