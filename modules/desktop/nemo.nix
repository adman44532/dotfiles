{pkgs, ...}: {
  # GUI File Manager, Nemo
  environment.systemPackages = with pkgs; [
    nemo-with-extensions
    tela-icon-theme # Required for Nemo
    xfce.tumbler
    w3m
  ];
}
