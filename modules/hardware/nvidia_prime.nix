{
  myLib,
  config,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "nvidia_prime" [] {
    # GPU driver module - must manually enable one GPU driver per machine
    # Configuration for Intel Xe Integrated Graphics & Nvidia 4060 Mobile GPU
    # This uses the Nvidia proprietary driver and is configured for hybrid graphics (SG mode in BIOS)

    nixpkgs.config.nvidia.acceptLicense = true;

    services.xserver.videoDrivers = ["nvidia"];

    hardware = {
      nvidia = {
        open = false;
        package = config.boot.kernelPackages.nvidiaPackages.beta;
        modesetting.enable = true;
        prime = {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };

          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
        };

        powerManagement = {
          enable = true;
          finegrained = true;
        };
      };

      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
  }
