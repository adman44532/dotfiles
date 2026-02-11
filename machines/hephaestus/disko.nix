{lib, ...}: let
  inherit (lib.lists) flatten;
  mntOpts = name: extra:
    flatten [
      "subvol=${name}"
      "noatime"
      "compress=zstd"
      extra
    ];
in {
  boot.initrd.luks.reusePassphrases = true;
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "512M";
              type = "EF02";
            };
            esp = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=007"];
              };
            };
            swap = {
              size = "64G";
              content = {
                type = "swap";
                randomEncryption = true;
                resumeDevice = true;
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "luks-main";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  extraArgs = ["-f"];
                  subvolumes = {
                    root = {
                      mountpoint = "/";
                      mountOptions = mntOpts "root" [];
                    };
                    snapshots = {
                      mountpoint = "/snapshots";
                      mountOptions = ["subvol=snapshots" "noatime" "nodatacow"];
                    };
                    storage = {
                      mountpoint = "/mnt/storage";
                      mountOptions = mntOpts "storage" [];
                    };
                    nix = {
                      mountpoint = "/nix";
                      mountOptions = mntOpts "nix" [];
                    };
                  };
                };
              };
            };
          };
        };
      };
      home = {
        type = "disk";
        device = "/dev/nvme1n1";
        content = {
          type = "gpt";
          partitions = {
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "luks-home";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  extraArgs = ["-f"];
                  subvolumes = {
                    storage = {
                      mountpoint = "/home";
                      mountOptions = mntOpts "home" [];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
