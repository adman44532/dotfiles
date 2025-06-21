{...}: {
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = builtins.map builtins.stringToNumber (builtins.split "\n" (builtins.readFile "../../secrets/tcp-ports.txt"));
  networking.firewall.allowedUDPPorts = builtins.map builtins.stringToNumber (builtins.split "\n" (builtins.readFile "../../secrets/udp-ports.txt"));
  networking.firewall.trustedInterfaces = ["tailscale0"];
}
