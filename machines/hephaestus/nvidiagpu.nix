{config, ...}: {
  # Configuration for GTX 1070 and RTX 2070S, and RTX 3080 as dedicated GPU
  # This uses the Nvidia proprietary driver

  nixpkgs.config.nvidia.acceptLicense = true;

  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    nvidia = {
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = true;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
