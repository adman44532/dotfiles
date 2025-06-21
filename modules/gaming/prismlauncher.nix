{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [prismlauncher temurin-jre-bin];
}
