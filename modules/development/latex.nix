{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user} = {
    home.packages = [
      pkgs.texlivePackages.tex-gyre
    ];
  };
}
