{
  myLib,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "spotify" ["multimedia"] {
    home-manager.users.${user}.programs.ncspot.enable = true; # A terminal Spotify client
  }
