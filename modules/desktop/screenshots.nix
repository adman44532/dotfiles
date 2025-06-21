{pkgs, ...}: {
  #! Screenshots with Grimblast, color picker with Hyprpicker
  environment.systemPackages = with pkgs; [grimblast hyprpicker];
}
