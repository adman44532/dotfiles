{pkgs, ...}: {
  environment.systemPackages = with pkgs; [evil-helix];
}
