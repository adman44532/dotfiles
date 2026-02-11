{
  myLib,
  pkgs,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "steam" ["gaming"] {
    # Enable Steam
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports for Steam Remote Play
      dedicatedServer.openFirewall =
        true; # Open ports for Source Dedicated Server
      localNetworkGameTransfers.openFirewall =
        true; # Open ports for local network game transfers
      gamescopeSession.enable = true;
    };

    # Environment variables for Steam
    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${user}/.steam/root/compatibilitytools.d";
    };

    # Additional system packages related to Steam
    environment.systemPackages = with pkgs; [
      protonup-ng
      (protontricks.override {inherit winetricks;})
      winetricks
      cabextract
    ];
  }
