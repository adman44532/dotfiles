{lib, ...}: let
  inherit (lib.lists) flatten;
  mntOpts = name: extra:
    flatten [
      "subvol=${name}"
      "noatime"
      "compress=zstd"
      extra
    ];

  rootId = "/dev/disk/by-id/nvme-GIGABYTE_AG4512G-SI_B10_BF2507320BE800488834";
in {
  boot.initrd.luks.reusePassphrases = true;
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = rootId;
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
            # Swap parition removed in favor of zram on hermes
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
                    nix = {
                      mountpoint = "/nix";
                      mountOptions = mntOpts "nix" [];
                    };
                    home = {
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
