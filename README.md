# The Supersuit

This is the repo where I configure my funny machines that are always breaking.

Established: 26th May 2023
NixOS-ified: 6th Nov 2024

## The USB Commands

A few times new I have needed to USB boot and fix the config from the outside.

1. **Enable flakes in NixOS configuration**  
   Add the following line to your `configuration.nix` then `sudo nixos-rebuild switch` to enable it:  
   ```nix
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
   ```  

2. **Check available drives**  
   Run:  
   `lsblk`  
   This will list all drives connected to the system.  

3. **Identify each drive**  
   - Mount each drive if needed and inspect its contents to confirm its purpose.  

4. **Mount the root partition**  
   Replace `sdXn` with your identified root partition:  
   `mount /dev/sdXn /mnt`  

5. **Generate a new configuration**  
   If using `disko`, add the `--no-filesystems` flag:  
   `nixos-generate-config --no-filesystems --root /mnt`  

6. **Verify drive names**  
   Ensure the drive names in `lsblk` match those in `disko-config.nix`.  

7. **Create a new boot generation**  
   Run:  
   `sudo nixos-rebuild boot --flake .#<name>`  

8. **Reboot**  
   Restart into the new configuration.  
