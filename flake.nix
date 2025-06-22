{
  description = "Where's my supersuit?";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    }; # MarceColl's flake was deprecated
    nix-fast-build = {
      url = "github:Mic92/nix-fast-build";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yazi.url = "github:sxyazi/yazi";
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-fast-build,
    yazi,
    ...
  } @ inputs: let
    # Default system architecture
    defaultSystem = "x86_64-linux";
    # Define a function that builds configurations for a specific system
    mkSystem = {
      hostname,
      user, # Default user
      system ? defaultSystem, # Use default system if not specified
      extraModules ? [],
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit hostname user yazi; # Pass variables to all NixOS modules
          inherit inputs;
        };
        modules =
          [
            # Base configuration
            ./machines/common/default.nix
            ./machines/${hostname}/configuration.nix
            ./machines/${hostname}/hardware-configuration.nix
            # Home Manager configuration
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";
              # Pass variables to Home Manager as well
              home-manager.extraSpecialArgs = {inherit hostname user yazi;};
              # Import user's home configuration
              home-manager.users.${user} = import ./machines/${hostname}/home.nix;
            }
          ]
          ++ extraModules;
      };
  in {
    formatter.${defaultSystem} = nixpkgs.legacyPackages.${defaultSystem}.alejandra;

    # Add nix-fast-build package to all systems
    packages = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux"] (system: {
      nix-fast-build = nix-fast-build.packages.${system}.default;
    });

    checks.${defaultSystem} = {
      hephaestus = self.nixosConfigurations.hephaestus.config.system.build.toplevel;
      hermes = self.nixosConfigurations.hermes.config.system.build.toplevel;
      hades = self.nixosConfigurations.hades.config.system.build.toplevel;
    };

    nixosConfigurations = {
      #! BIG BIG WARNING - Ensure that the hostname matches the machine folders
      hephaestus = mkSystem {
        hostname = "hephaestus";
        user = builtins.readFile ./secrets/username1.txt;
        extraModules = [];
      };
      hermes = mkSystem {
        hostname = "hermes";
        user = builtins.readFile ./secrets/username1.txt;
        extraModules = [];
      };
      hades = mkSystem {
        hostname = "hades";
        user = builtins.readFile ./secrets/username2.txt;
        extraModules = [];
      };
    };
  };
}
