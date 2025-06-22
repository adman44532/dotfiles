{lib, ...}: let
  tcp-ports-file = builtins.readFile ../../secrets/allowedTCPPorts.txt;
  tcp-lines = lib.strings.splitString "\n" tcp-ports-file;
  tcp-non-empty-lines = lib.lists.filter (s: s != "") tcp-lines;
  tcp-ports = map lib.strings.toIntBase10 tcp-non-empty-lines;

  udp-ports-file = builtins.readFile ../../secrets/allowedUDPPorts.txt;
  udp-lines = lib.strings.splitString "\n" udp-ports-file;
  udp-non-empty-lines = lib.lists.filter (s: s != "") udp-lines;
  udp-ports = map lib.strings.toIntBase10 udp-non-empty-lines;
in {
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = tcp-ports;
  networking.firewall.allowedUDPPorts = udp-ports;
  networking.firewall.trustedInterfaces = ["tailscale0"];
}
