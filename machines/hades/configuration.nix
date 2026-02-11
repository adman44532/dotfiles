{
  pkgs,
  user,
  inputs,
  ...
}: let
  inherit (inputs) disko;
  inherit (inputs) stylix;
in {
  system.stateVersion = "25.05";

  imports = [
    disko.nixosModules.disko
    stylix.nixosModules.stylix
    ./networking.nix
  ];

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video" "gamemode" "plugdev" "storage" "docker"];
  };

  environment.systemPackages = with pkgs; [
    immich-go
    jdk17
    screen
  ];
}
