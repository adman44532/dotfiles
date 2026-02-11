{lib, ...}: let
  inherit (lib.lists) flatten;
  mntOpts = name: extra:
    flatten [
      "subvol=${name}"
      "noatime"
      "compress=zstd"
      extra
    ];
  # Always use /dev/disk/by-id to avoid issues with drive enumeration changing
  rootId = "/dev/disk/by-id/nvme-T-FORCE_TM8FPZ001T_TPBF2503270040100073";
  hdd1Id = "/dev/disk/by-id/ata-ST2000DM001-1ER164_Z4Z69NL9";
  hdd2Id = "/dev/disk/by-id/ata-ST2000DM008-2FR102_WK3094ZH";
  hdd3Id = "/dev/disk/by-id/ata-ST2000DM008-2FR102_WK30E7NM";
  hdd4Id = "/dev/disk/by-id/ata-ST2000DM008-2FR102_WFL5NYYZ";
in {
  boot = {
    supportedFilesystems = ["zfs"];
    zfs.devNodes = "/dev/disk/by-id";
    zfs.extraPools = ["zpool"];
  };
  networking.hostId = "8425e349";

  disko.devices = {
    # This is where we actually define the hardware and its layout
    disk = {
      # This is the main 1TB NVMe drive, it will hold the OS, the containers, and anything we need fast access to (e.g. Game Servers)
      main = {
        type = "disk";
        device = rootId;
        content = {
          type = "gpt";
          partitions = {
            # This is basically my standard BTRFs layout, but instead of LUKS it's just plain BTRFs
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
                mountOptions = ["umask=0077"];
              };
            };
            swap = {
              size = "32G";
              content = {
                type = "swap";
              };
            };
            btrfs = {
              size = "100%";
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
                  home = {
                    mountpoint = "/home";
                    mountOptions = mntOpts "home" [];
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
      # These are the four 4TB Drives in a 2-Way Mirror ZFS pool for bulk storage and redundancy
      hdd1 = {
        type = "disk";
        device = hdd1Id;
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zpool";
              };
            };
          };
        };
      };
      hdd2 = {
        type = "disk";
        device = hdd2Id;
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zpool";
              };
            };
          };
        };
      };
      hdd3 = {
        type = "disk";
        device = hdd3Id;
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zpool";
              };
            };
          };
        };
      };
      hdd4 = {
        type = "disk";
        device = hdd4Id;
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zpool";
              };
            };
          };
        };
      };
    };
    # With all the hardware defined, we can define the ZFS pool. This is a 2-Way Mirror pool with two vdevs, each vdev being a mirror of two drives.
    # This gives us redundancy and good read performance, while still being able to recover from a single drive failure in each vdev.
    # The pool is mounted at /mnt/storage and uses zstd compression and automatic snapshots.
    zpool = {
      zpool = {
        type = "zpool";
        mode = {
          topology = {
            type = "topology";
            vdev = [
              {
                mode = "mirror";
                members = ["hdd1" "hdd2"];
              }
              {
                mode = "mirror";
                members = ["hdd3" "hdd4"];
              }
            ];
          };
        };
        rootFsOptions = {
          compression = "zstd";
          "com.sun:auto-snapshot" = "true";
        };
        datasets = {
          "storage" = {
            type = "zfs_fs";
            # This was really key to getting this to work properly. Without this, systemd and zfs would both try and mount the pool. By setting this to "legacy", we tell zfs to not mount it, and let systemd handle it.
            options.mountpoint = "legacy";
            mountpoint = "/mnt/storage";
          };
        };
      };
    };
  };
}
