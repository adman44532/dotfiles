{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  # This module is intended for Hermes only, as other devices have sufficient RAM.
  mkModule "zram" [] {
    environment.systemPackages = with pkgs; [
      lz4
    ];
    zramSwap = {
      enable = true;
      algorithm = "lz4";
      swapDevices = 1;
      memoryPercent = 75;
      priority = 100;
    };
    boot = {
      kernel.sysctl."vm.swappiness" = 180; # High swappiness encourages swapping to zram for compression benefits on memory-constrained systems
      initrd.kernelModules = ["lz4"];
    };
  }
