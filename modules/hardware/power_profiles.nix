{
  myLib,
  user,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "power_profiles" [] {
    environment.systemPackages = with pkgs; [
      power-profiles-daemon
    ];

    # Enable power management services
    services.power-profiles-daemon.enable = true;
    services.thermald.enable = true;
    powerManagement.cpuFreqGovernor = "ondemand";

    # Polkit rules for seamless power profile switching
    security.polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
          if (action.id == "org.freedesktop.UPower.Daemon" &&
              subject.isInGroup("wheel")) {
              return polkit.Result.YES;
          }
      });
    '';
  }
