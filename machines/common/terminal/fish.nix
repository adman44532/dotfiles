{
  pkgs,
  config,
  user,
  ...
}: {
  # Sets Fish as the default shell for the main user, but can be used globally.
  # Bash is installed along side as a backup for running POSIX scripts (Like rebuild!)
  # Global Shell Aliases are held here, but package dependant ones are bundled with the app.
  # The programs are hardcoded to use fish. Swapping to something else requires changes.
  environment.systemPackages = with pkgs; [fish bash];
  programs.fish = {
    enable = true;
    shellAliases = {}; # Globals
  };

  users.defaultUserShell = pkgs.fish;

  home-manager.users.${user} = {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        fish_vi_key_bindings

      '';
      shellAliases = {};
    };
  };
}
