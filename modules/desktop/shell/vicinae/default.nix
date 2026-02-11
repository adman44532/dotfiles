{
  myLib,
  user,
  pkgs,
  inputs,
  ...
}: let
  inherit (myLib) mkModule;
  inherit (inputs) vicinae vicinae-extensions;
  system = pkgs.stdenv.hostPlatform.system;
in
  mkModule "vicinae" ["desktop"] {
    home-manager.users.${user} = {
      programs.vicinae = {
        enable = true;
        package = vicinae.packages.${system}.default;
        systemd = {
          enable = true;
          autoStart = true;
        };
        settings = {
          close_on_focus_loss = true;
          pop_to_root_on_close = true;
          search_files_in_root = true;
        };
        extensions = with vicinae-extensions.packages.${system}; [
          nix
          mullvad
          searxng
          power-profile
        ];
      };
    };
  }
