{
  config,
  pkgs,
  inputs,
  user,
  system,
  nixos-hardware,
  ...
}: {
  # Configuration for Main PC
  # Ryzen 9 3900X, Radeon RX 9070XT

  system.stateVersion = "24.11";

  imports = [
    ./nvidia_gpu.nix
    ./power-profiles.nix
    inputs.stylix.nixosModules.stylix

    # Module Selection
    ../../modules/desktop
    ../../modules/development
    ../../modules/gaming
    ../../modules/multimedia
    ../../modules/social
    ../../modules/utilities
    ../../modules/web/searxng.nix
    ../../modules/web/browsers/zen.nix # Default Browser
    ../../modules/web/browsers/brave.nix
  ];

  # Machine Specific Packages
  environment.systemPackages = with pkgs; [
    microcodeAmd
    playerctl
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Resolved pixelated images in electron apps
  };

  # User
  users.users.${user} = {
    isNormalUser = true;
    description = "user";
    extraGroups = ["networkmanager" "wheel" "video" "gamemode" "plugdev" "storage" "docker"];
  };

  # Include Firefox as a backup browser
  programs.firefox.enable = true;

  # Additional Services

  services.libinput.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
