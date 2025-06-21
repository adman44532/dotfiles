{...}: {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = false;
      AllowUsers = [builtins.readFile ../../secrets/username2.txt];
    };
    ports = [(builtins.stringToNumber (builtins.readFile ../../secrets/ssh-port.txt))];
  };
}
