{pkgs, ...}: {
  environment.systemPackages = with pkgs; [localsend];
  programs.localsend.enable = true;
  programs.localsend.openFirewall = true;
}
