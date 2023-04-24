{
  config,
  pkgs,
  ...
}: let
  package = pkgs.postgresql_14;
  logsDir = "/usr/local/var/log";
in {
  services.postgresql = {
    enable = true;

    package = package;
    dataDir = "/usr/local/var/postgres";
    extraPlugins = [package.pkgs.postgis];
    settings = {
      timezone = "UTC";
      max_locks_per_transaction = 1024;
    };

    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
  };

  launchd.user.agents.postgresql.serviceConfig = {
    StandardErrorPath = "${logsDir}/postgres.error.log";
    StandardOutPath = "${logsDir}/postgres.log";
  };
}
