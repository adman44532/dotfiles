{
  inputs,
  pkgs,
  hostname,
  lib,
  ...
}: let
  inherit (lib.attrsets) attrNames attrValues filterAttrs mapAttrs;
  inherit (lib.types) isType;
in {
  # This is configuration shared between all machines

  imports = [./terminal];

  #! NIXOS SETTINGS
  nixpkgs.config.allowUnfree = true;

  nix = {
    # package = inputs.nixpkgs.legacyPackages.${pkgs.system}.git;
    registry = mapAttrs (_: v: {flake = v;}) (filterAttrs (_: v: isType "flake" v) inputs);
    extraOptions = "gc-keep-outputs = true";

    settings = let
      cachix = {
        "https://nix-community.cachix.org" = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
        "https://hyprland.cachix.org" = "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=";
        "https://ghostty.cachix.org" = "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns=";
        "https://neovim-nightly.cachix.org" = "neovim-nightly.cachix.org-1:feIoInHRevVEplgdZvQDjhp11kYASYCE2NGY9hNrwxY=";
        # "https://ros.cachix.org" = "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo=";
      };
    in {
      builders-use-substitutes = true;
      auto-optimise-store = true;
      warn-dirty = false;
      experimental-features = [
        "nix-command"
        "flakes"
        "auto-allocate-uids"
      ];
      substituters = attrNames cachix;
      trusted-public-keys = attrValues cachix;
      trusted-users = ["root"];
      allowed-users = ["@wheel"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  #! BOOTLOADER
  boot.loader = {
    systemd-boot.enable = true; # Disable systemd-boot
    efi.canTouchEfiVariables = true; # Necessary for EFI bootloaders
    efi.efiSysMountPoint = "/boot";
  };

  #! NETWORKING
  networking.hostName = "${hostname}"; # Define the hostname
  networking.networkmanager.enable = true;
  services.fail2ban.enable = true; # Enable fail2ban to ban IPs that show malicious signs
  networking.firewall.enable = true; # Enable the firewall
  networking.nameservers = ["1.1.1.1" "9.9.9.9"];

  #! DOCKER
  virtualisation.docker.enable = true;

  #! TAILESCALE
  services.tailscale.enable = true;

  #! PACKAGES
  environment.systemPackages = with pkgs; [
    # Essential Packages as they are used in the ./rebuild script
    # First load should be using the standard nixos-rebuild, 2nd can be with ./rebuild
    nix-output-monitor
    nix-fast-build
    nvd
    git
    gh
    vim
    alejandra
    nixd
    git-crypt

    # Packages are ordered from top to bottom
    efibootmgr
    os-prober
    wget
  ];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  #! MISC & LOCALE
  time.timeZone = "Australia/Sydney";
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };
}
