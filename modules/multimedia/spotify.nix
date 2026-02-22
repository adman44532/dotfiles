{myLib, inputs, pkgs, ...}: let
  inherit (myLib) mkModule;
  spicePkgs = inputs.spicetify.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
  mkModule "spotify" ["multimedia"] {
    programs.spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock # Block ads
        hidePodcasts # Remove podcast UI elements
        shuffle # Proper Fisher-Yates shuffle (fixes Spotify's biased shuffle)
        keyboardShortcut # Vim-like navigation
        trashbin # Permanently skip specific artists/songs
        powerBar # Spotlight-like search bar
        beautifulLyrics # Enhanced lyrics with karaoke/line sync
        fullAppDisplay # Fullscreen song display with cover art
        volumePercentage # Show volume percentage in UI
        history # View listening history
      ];
    };
  }
