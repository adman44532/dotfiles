{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "mullvad" ["networking" "utilities"] {
    services.mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
    # Service automatically installs required packages, no manual package installation needed
  }
