{
  config,
  pkgs,
  user,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gh # This is installed in the system environment due to conflicts in authentication paths
  ];
  home-manager.users.${user}.programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
}
