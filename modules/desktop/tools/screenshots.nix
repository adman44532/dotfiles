{
  myLib,
  pkgs,
  ...
}: let
  inherit (myLib) mkModule;

  # Example of shell script integration in NixOS modules
  screenshotScript = pkgs.writeShellScriptBin "screenshot" ''
    # Source XDG user directories
    [[ -f ~/.config/user-dirs.dirs ]] && source ~/.config/user-dirs.dirs

    # Set output directory with fallbacks
    OUTPUT_DIR="''${XDG_PICTURES_DIR:-$HOME/Pictures}"

    # Check if output directory exists
    if [[ ! -d "$OUTPUT_DIR" ]]; then
      # Check if notify-send exists before using it
      if command -v notify-send &> /dev/null; then
        notify-send "Screenshot directory does not exist: $OUTPUT_DIR" -u critical -t 3000
      fi
      exit 1
    fi

    # Take screenshot with hyprshot and edit with satty
    pkill slurp || hyprshot -m ''${1:-region} --raw | \
      satty --filename - \
        --output-filename "$OUTPUT_DIR/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png" \
        --early-exit \
        --actions-on-enter save-to-clipboard \
        --save-after-copy \
        $(command -v wl-copy &> /dev/null && echo "--copy-command 'wl-copy'")
  '';
in
  mkModule "screenshots" ["desktop"] {
    # Install screenshot tools and dependencies
    environment.systemPackages = with pkgs; [
      screenshotScript # Custom screenshot script
      hyprshot # Screenshot utility for Hyprland
      satty # Screenshot annotation tool
      slurp # Region selector for Wayland
    ];
  }
