_: {
  networking.firewall = {
    allowedTCPPorts = [25565 7777 15636 15637 8080 80 443];
    allowedUDPPorts = [25565 7777 15636 15637 24454];
  };
}
