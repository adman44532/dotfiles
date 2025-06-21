{pkgs, ...}: {
  environment.systemPackages = with pkgs; [fselect];
}
