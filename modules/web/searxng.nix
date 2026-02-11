{
  myLib,
  inputs,
  system,
  ...
}: let
  inherit (myLib) mkModule;
  inherit (inputs) nixpkgs-stable;
  secret = (builtins.fromTOML (builtins.readFile ../../machines/secrets.toml)).searxng.secret_key;
in
  mkModule "searxng" ["web"] {
    services.searx = {
      enable = true;
      package = nixpkgs-stable.legacyPackages.${system}.searxng;
      redisCreateLocally = true;
      settings.server = {
        bind_address = "::1";
        port = 8080;
        secret_key = secret;
        enabled_plugins = [
          "Basic Calculator"
          "Hash plugin"
          "Tor check plugin"
          "Open Access DOI rewrite"
          "Hostnames plugin"
          "Unit converter plugin"
          "Tracker URL remover"
          "User Agent"
        ];

        search = {
          safe_search = 0;
          autocomplete_min = 2;
          autocomplete = "brave";
        };
      };
    };
  }
