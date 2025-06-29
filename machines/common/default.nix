{
  pkgs,
  hostname,
  inputs,
  ...
}: {
  # This is configuration shared between all machines

  imports = [./terminal];

  #! NIXOS SETTINGS
  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.config.allowUnfree = true;

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
