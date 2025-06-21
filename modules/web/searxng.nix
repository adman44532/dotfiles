{...}: {
  services.searx = {
    enable = true;
    redisCreateLocally = true;
    settings.server = {
      bind_address = "::1";
      port = 8080;
      secret_key = "shrek5willbea5outta5";
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
