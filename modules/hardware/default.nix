{...}: {
  imports = [
    ./amdgpu.nix
    ./bluetooth.nix
    ./audio.nix
    ./zram.nix
    ./zswap.nix
    ./nvidia_prime.nix
    ./power_profiles.nix
  ];
}
