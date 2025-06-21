{
  pkgs,
  user,
  ...
}: {
  environment.systemPackages = with pkgs; [
    rofi-power-menu
    rofimoji
    rofi-calc
  ];

  home-manager.users.${user} = {
    lib,
    config,
    ...
  }: {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;

      cycle = false;
      terminal = "ghostty";
      location = "center";

      plugins = builtins.attrValues {
        inherit (pkgs) rofimoji rofi-power-menu rofi-calc;
      };

      theme = lib.mkForce ./theme.rasi;
    };
  };
}
