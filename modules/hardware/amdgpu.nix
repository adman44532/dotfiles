{
  config,
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "amdgpu" [] {
    # GPU driver module - must manually enable one GPU driver per machine
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    environment.systemPackages = with pkgs; [
      vulkan-tools
      lact
    ];

    systemd.packages = with pkgs; [lact];
    systemd.services.lactd.wantedBy = ["multi-user.target"];
  }
