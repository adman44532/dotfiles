{
  description = "Where's my supersuit?";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvim-nix.url = "github:adman44532/nvim-nix";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    }; # MarceColl's flake was deprecated
    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yazi = {
      url = "github:sxyazi/yazi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    vicinae = {
      url = "github:vicinaehq/vicinae";
    };
    vicinae-extensions = {
      url = "github:vicinaehq/extensions";
    };
    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    defaultSystem = "x86_64-linux";
    mkSystem = {
      hostname,
      user,
      system ? defaultSystem,
      extraModules ? [],
    }:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit hostname user system;
          inherit inputs;
          myLib = import ./lib {
            inherit (nixpkgs) lib;
            enables = import ./machines/${hostname}/modules.nix;
          };
        };
        modules =
          [
            ./modules/base.nix
            ./machines/${hostname}/configuration.nix
            ./machines/${hostname}/hardware-configuration.nix
            ./machines/${hostname}/disko.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "bak";
                extraSpecialArgs = {inherit hostname user inputs;};
                sharedModules = [inputs.vicinae.homeManagerModules.default];
                users.${user} = import ./machines/${hostname}/home.nix;
              };
            }
          ]
          ++ extraModules;
      };
  in {
    formatter.${defaultSystem} = nixpkgs.legacyPackages.${defaultSystem}.alejandra;

    nixosConfigurations = {
      # WARN: Make sure hostnames match the folders in ./machines/
      hephaestus = mkSystem {
        hostname = "hephaestus";
        user = "adman";
        extraModules = [];
      };
      hermes = mkSystem {
        hostname = "hermes";
        user = "adman";
        extraModules = [];
      };
      hades = mkSystem {
        hostname = "hades";
        user = "nico";
        extraModules = [];
      };
    };
  };
}
