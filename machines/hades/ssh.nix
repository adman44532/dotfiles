{lib, ...}: {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = false;
      AllowUsers = [(lib.strings.removeSuffix "\n" (builtins.readFile ../../secrets/username2.txt))];
    };
    ports = [(lib.toInt (lib.strings.removeSuffix "\n" (builtins.readFile ../../secrets/ssh-port.txt)))];
  };
}
