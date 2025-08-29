{
  pkgs,
  user,
  ...
}: {
  system.stateVersion = "24.11";

  imports = [
    ./networking.nix
    ./ssh.nix
  ];

  environment.systemPackages = with pkgs; [immich-go jdk17 screen];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "user";
    extraGroups = ["networkmanager" "wheel" "docker"];
    # packages = with pkgs; [];
  };
}
