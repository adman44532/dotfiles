{
  myLib,
  pkgs,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "bitwarden" ["utilities"] {
    environment.systemPackages = with pkgs; [bitwarden-desktop bitwarden-cli];
    environment.sessionVariables = {
      SSH_AUTH_SOCK = "/home/${user}/.bitwarden-ssh-agent.sock";
    };
  }
