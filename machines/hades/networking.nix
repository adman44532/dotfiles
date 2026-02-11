_: {
  networking.firewall = {
    allowedTCPPorts = [25565 7777 15636 15637 8080 80 443];
    allowedUDPPorts = [25565 7777 15636 15637 24454];
    trustedInterfaces = ["tailscale0"];
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = false;
      AllowUsers = ["nico"];
    };
    ports = [22];
  };
}
