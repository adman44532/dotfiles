{
  config,
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user}.programs.mangohud = {
    enable = true;
    enableSessionWide = false;
    settings = {
      output_folder = "/home/${user}/tmp";
      toggle_hud = "Shift_L+F5";
      toggle_logging = "Shift_L+F2";
      log_duration = 300; # 5 Minutes
      # preset = "4";
      gpu_stats = true;
      gpu_temp = true;
      cpu_stats = true;
      cpu_temp = true;
      vram = true;
      fps = true;
      frame_timing = 1;
      gamemode = true;
    };
  };
}
