{pkgs, ...}: let
  user = "nico";
  hostName = "hades";
  timeZone = "Australia/Sydney";
  locale = "en_AU.UTF-8";
in {
  imports = [
    ./hardware-configuration.nix
    "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    ./disko.nix
  ];

  system.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "auto-allocate-uids"
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
  };

  networking = {
    inherit hostName;
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    nameservers = ["1.1.1.1" "9.9.9.9"];
  };

  time.timeZone = timeZone;

  i18n.defaultLocale = locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = locale;
    LC_IDENTIFICATION = locale;
    LC_MEASUREMENT = locale;
    LC_MONETARY = locale;
    LC_NAME = locale;
    LC_NUMERIC = locale;
    LC_PAPER = locale;
    LC_TELEPHONE = locale;
    LC_TIME = locale;
  };

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video" "gamemode" "plugdev" "storage" "docker"];
  };

  environment.systemPackages = with pkgs; [
    microcode-amd
    git
    gh
    vim
    git-crypt
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    flake = "/home/${user}/.dotfiles";
  };
}
