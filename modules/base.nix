{
  inputs,
  pkgs,
  lib,
  hostname,
  myLib,
  user,
  ...
}: let
  inherit (lib.attrsets) attrNames attrValues filterAttrs mapAttrs;
  inherit (lib.types) isType;
in {
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
    inputs.spicetify.nixosModules.spicetify
    ./default.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    registry = mapAttrs (_: v: {flake = v;}) (filterAttrs (_: v: isType "flake" v) inputs);
    extraOptions = "gc-keep-outputs = true";
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];

    settings = let
      cachix = {
        "https://nix-community.cachix.org" = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
        "https://hyprland.cachix.org" = "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=";
        "https://ghostty.cachix.org" = "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns=";
        "https://neovim-nightly.cachix.org" = "neovim-nightly.cachix.org-1:feIoInHRevVEplgdZvQDjhp11kYASYCE2NGY9hNrwxY=";
        "https://yazi.cachix.org" = "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k=";
        "https://vicinae.cachix.org" = "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=";
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
      trusted-users = ["root" "@wheel"];
      allowed-users = ["@wheel"];
    };
    # GC Handled by NH
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
  };

  networking = {
    hostName = "${hostname}";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    firewall = {
      enable = true;
      trustedInterfaces = ["tailscale0"];
    };
    nameservers = ["1.1.1.1" "9.9.9.9"];
  };
  services.fail2ban.enable = true;

  virtualisation.docker.enable = true;

  services.tailscale.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = false;
    };
  };

  environment.systemPackages = with pkgs; [
    microcode-amd
    git
    gh
    vim
    git-crypt
  ];

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    flake = "/home/${user}/.dotfiles"; # Hardcoded here because nh needs actual path at evaluation time
  };

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
