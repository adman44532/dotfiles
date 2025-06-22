{pkgs, ...}: {
  # AMD GPU Setup for RX 9070XT

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # Testing Packages
    # rocmPackages.rocminfo
    # rocmPackages.rocm-smi
    # clinfo
    vulkan-tools
    lact
  ];

  systemd.packages = with pkgs; [lact];
  systemd.services.lactd.wantedBy = ["multi-user.target"];
}
