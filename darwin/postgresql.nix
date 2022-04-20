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
    extraConfig = ''
      timezone = 'UTC'
    '';
  };

  launchd.user.agents.postgresql.serviceConfig = {
    StandardErrorPath = "${logsDir}/postgres.error.log";
    StandardOutPath = "${logsDir}/postgres.log";
  };
}
