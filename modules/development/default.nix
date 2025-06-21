{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./latex.nix
    ./vscode.nix
  ];
}
