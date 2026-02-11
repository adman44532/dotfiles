{...}: {
  # Neovim comes stock standard with all my builds
  # Helix also comes as a backup increase nvim breaks
  # Docker is also universal across devices
  imports = [
    ./latex.nix
    ./zed.nix
    ./opencode.nix
    ./gitbutler.nix
  ];
}
