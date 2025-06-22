{
  pkgs,
  inputs,
  user,
  ...
}: {
  # Configuration for Main PC
  # Ryzen 9 3900X, Radeon RX 9070XT

  system.stateVersion = "25.05";

  imports = [
    inputs.disko.nixosModules.disko
    inputs.stylix.nixosModules.stylix
    ./disko-config.nix
    ./amdgpu.nix

    # Module Selection
    ../../modules/desktop
    ../../modules/development
    ../../modules/gaming
    ../../modules/multimedia
    ../../modules/social
    ../../modules/utilities
    ../../modules/web/searxng.nix
    ../../modules/web/browsers/zen.nix # Default Browser
    ../../modules/web/browsers/brave.nix # Backup Browser
  ];

  # Kernel & Firmware Changes
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_testing;
  hardware.enableAllFirmware = true;
  boot.kernelParams = [
    "video=DP-1:3440x1440@60"
    "video=HDMI-A-1:1920x1080@60"
  ];

  # chaotic.mesa-git.enable = true;
  # chaotic.hdr.enable = true;
  # chaotic.nyx.cache.enable = true;

  # Machine Specific Packages
  environment.systemPackages = with pkgs; [
    microcodeAmd
    playerctl
  ];

  # User
  users.users.${user} = {
    isNormalUser = true;
    description = "user";
    extraGroups = ["networkmanager" "wheel" "video" "gamemode" "plugdev" "storage" "docker"];
  };

  # Include Firefox as a backup browser
  programs.firefox.enable = true;

  # Additional Services

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
