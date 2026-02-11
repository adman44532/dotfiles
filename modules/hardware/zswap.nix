{
  myLib,
  hostname,
  ...
}: let
  inherit (myLib) mkModule;

  zswapConfig = {
    hephaestus = {
      maxPoolPercent = 15; # 15% of RAM for zswap pool
      swappiness = 25;
    };
    hades = {
      maxPoolPercent = 20; # 20% of RAM for zswap pool (more RAM available)
      swappiness = 15;
    };
  };

  config = zswapConfig.${hostname} or null;
in
  mkModule "zswap" [] {
    boot = {
      kernelParams =
        if config != null
        then [
          "zswap.enabled=1"
          "zswap.compressor=zstd"
          "zswap.zpool=zsmalloc"
          "zswap.max_pool_percent=${toString config.maxPoolPercent}"
        ]
        else [];

      initrd.kernelModules =
        if config != null
        then ["zstd"]
        else [];

      kernel.sysctl."vm.swappiness" =
        if config != null
        then config.swappiness
        else 0;
    };
  }
